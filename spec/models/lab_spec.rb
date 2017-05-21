require 'rails_helper'
RSpec.describe Lab do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @lab=FactoryGirl.build(:lab)
      end
      it "should pass validation" do
        expect(@lab.valid?).to be (true)
      end
    end
  end
  describe ":name" do
    context "Name Null" do
      before :each do
        @lab=FactoryGirl.build(:lab,name:nil)
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:name)
      end
    end
    context "Name Blank" do
      before :each do
        @lab=FactoryGirl.build(:lab,name:"")
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:name)
      end
    end
    context "Name Too Short" do
      before :each do
        @lab=FactoryGirl.build(:lab,name:"ss")
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:name)
      end
    end
    context "Name Too Long" do
      before :each do
        @lab=FactoryGirl.build(:lab,name:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:name)
      end
    end
  end
  describe ":address" do
    context "address Null" do
      before :each do
        @lab=FactoryGirl.build(:lab,address:nil)
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:address)
      end
    end
    context "address Blank" do
      before :each do
        @lab=FactoryGirl.build(:lab,address:"")
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:address)
      end
    end
    context "address Too Short (Less than 10)" do
      before :each do
        @lab=FactoryGirl.build(:lab,address:9.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:address)
      end
    end
    context "address Too Long" do
      before :each do
        @lab=FactoryGirl.build(:lab,address:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@lab.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @lab.valid?
        expect(@lab.errors.details).to include (:address)
      end
    end
  end

end
