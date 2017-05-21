require 'rails_helper'
RSpec.describe Tag do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @tag=FactoryGirl.build(:tag)
      end
      it "should pass validation" do
        expect(@tag.valid?).to be (true)
      end
    end
  end
  describe ":name" do
    context "Name Null" do
      before :each do
        @tag=FactoryGirl.build(:tag,name:nil)
      end
      it "should not pass validation" do
        expect(@tag.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @tag.valid?
        expect(@tag.errors.details).to include (:name)
      end
    end
    context "Name Blank" do
      before :each do
        @tag=FactoryGirl.build(:tag,name:"")
      end
      it "should not pass validation" do
        expect(@tag.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @tag.valid?
        expect(@tag.errors.details).to include (:name)
      end
    end
    context "Name Too Short" do
      before :each do
        @tag=FactoryGirl.build(:tag,name:"ss")
      end
      it "should not pass validation" do
        expect(@tag.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @tag.valid?
        expect(@tag.errors.details).to include (:name)
      end
    end
    context "Name Too Long" do
      before :each do
        @tag=FactoryGirl.build(:tag,name:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@tag.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @tag.valid?
        expect(@tag.errors.details).to include (:name)
      end
    end
    context "Name Repeated" do
      before :each do
        @tag_existent=FactoryGirl.create(:tag,name:"tag1")
        @tag=FactoryGirl.build(:tag,name:"tag1")
      end
      it "should not pass validation" do
        expect(@tag.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @tag.valid?
        expect(@tag.errors.details).to include (:name)
      end
    end
  end

end
