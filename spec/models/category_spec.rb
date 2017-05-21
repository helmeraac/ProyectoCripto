require 'rails_helper'
RSpec.describe Category do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @category=FactoryGirl.build(:category)
      end
      it "should pass validation" do
        expect(@category.valid?).to be (true)
      end
    end
  end
  describe ":name" do
    context "Name Null" do
      before :each do
        @category=FactoryGirl.build(:category,name:nil)
      end
      it "should not pass validation" do
        expect(@category.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @category.valid?
        expect(@category.errors.details).to include (:name)
      end
    end
    context "Name Blank" do
      before :each do
        @category=FactoryGirl.build(:category,name:"")
      end
      it "should not pass validation" do
        expect(@category.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @category.valid?
        expect(@category.errors.details).to include (:name)
      end
    end
    context "Name Too Short" do
      before :each do
        @category=FactoryGirl.build(:category,name:"ss")
      end
      it "should not pass validation" do
        expect(@category.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @category.valid?
        expect(@category.errors.details).to include (:name)
      end
    end
    context "Name Too Long" do
      before :each do
        @category=FactoryGirl.build(:category,name:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@category.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @category.valid?
        expect(@category.errors.details).to include (:name)
      end
    end
    context "Name Repeated" do
      before :each do
        @category_existent=FactoryGirl.create(:category,name:"Category1")
        @category=FactoryGirl.build(:category,name:"Category1")
      end
      it "should not pass validation" do
        expect(@category.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @category.valid?
        expect(@category.errors.details).to include (:name)
      end
    end
  end

end
