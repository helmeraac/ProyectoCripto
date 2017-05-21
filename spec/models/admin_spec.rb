require 'rails_helper'
RSpec.describe Admin do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @admin=FactoryGirl.build(:admin)
      end
      it "should pass validation" do
        expect(@admin.valid?).to be (true)
      end
    end
  end
  describe ":email" do
    context "Email Null" do
      before :each do
        @admin=FactoryGirl.build(:admin,email:nil)
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:email)
      end
    end
    context "Email Blank" do
      before :each do
        @admin=FactoryGirl.build(:admin,email:"")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:email)
      end
    end
    context "Email Present but Not Valid" do
      before :each do
        @admin=FactoryGirl.build(:admin,email:"asdad.com")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:email)
      end
    end
  end
  describe ":password" do
    context "Password Null" do
      before :each do
        @admin=FactoryGirl.build(:admin,password:nil)
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:password)
      end
    end
    context "Password Blank" do
      before :each do
        @admin=FactoryGirl.build(:admin,password:"")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:password)
      end
    end
    context "Password Too Short" do
      before :each do
        @admin=FactoryGirl.build(:admin,password:"asd")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:password)
      end
    end
  end
  describe ":name" do
    context "Name Null" do
      before :each do
        @admin=FactoryGirl.build(:admin,name:nil)
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:name)
      end
    end
    context "Name Blank" do
      before :each do
        @admin=FactoryGirl.build(:admin,name:"")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:name)
      end
    end
    context "Name Too Short" do
      before :each do
        @admin=FactoryGirl.build(:admin,name:"ss")
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:name)
      end
    end
    context "Name Too Long" do
      before :each do
        @admin=FactoryGirl.build(:admin,name:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:name)
      end
    end
  end
  describe ":bio" do
    context "Bio Null" do
      before :each do
        @admin=FactoryGirl.build(:admin,bio:nil)
      end
      it "should pass validation" do
        expect(@admin.valid?).to be (true)
      end
    end
    context "Bio Blank" do
      before :each do
        @admin=FactoryGirl.build(:admin,bio:"")
      end
      it "should pass validation" do
        expect(@admin.valid?).to be (true)
      end
    end
    context "Bio Too Long" do
      before :each do
        @admin=FactoryGirl.build(:admin,bio:501.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@admin.valid?).to be (false)
      end
      it "should contain an error on bio field" do
        @admin.valid?
        expect(@admin.errors.details).to include (:bio)
      end
    end
  end
  describe ":photo" do
    context "photo Null" do
      before :each do
        @admin=FactoryGirl.build(:admin,photo:nil)
      end
      it "should pass validation" do
        expect(@admin.valid?).to be (true)
      end
    end
    context "photo Blank" do
      before :each do
        @admin=FactoryGirl.build(:admin,photo:"")
      end
      it "should pass validation" do
        expect(@admin.valid?).to be (true)
      end
    end

  end
end
