require 'rails_helper'
RSpec.describe User do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @user=FactoryGirl.build(:user)
      end
      it "should pass validation" do
        expect(@user.valid?).to be (true)
      end
    end
  end
  describe ":email" do
    context "Email Null" do
      before :each do
        @user=FactoryGirl.build(:user,email:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @user.valid?
        expect(@user.errors.details).to include (:email)
      end
    end
    context "Email Blank" do
      before :each do
        @user=FactoryGirl.build(:user,email:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @user.valid?
        expect(@user.errors.details).to include (:email)
      end
    end
    context "Email Present but Not Valid" do
      before :each do
        @user=FactoryGirl.build(:user,email:"asdad.com")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on email field" do
        @user.valid?
        expect(@user.errors.details).to include (:email)
      end
    end
  end
  describe ":password" do
    context "Password Null" do
      before :each do
        @user=FactoryGirl.build(:user,password:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @user.valid?
        expect(@user.errors.details).to include (:password)
      end
    end
    context "Password Blank" do
      before :each do
        @user=FactoryGirl.build(:user,password:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @user.valid?
        expect(@user.errors.details).to include (:password)
      end
    end
    context "Password Too Short" do
      before :each do
        @user=FactoryGirl.build(:user,password:"asd")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on password field" do
        @user.valid?
        expect(@user.errors.details).to include (:password)
      end
    end
  end
  describe ":name" do
    context "Name Null" do
      before :each do
        @user=FactoryGirl.build(:user,name:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @user.valid?
        expect(@user.errors.details).to include (:name)
      end
    end
    context "Name Blank" do
      before :each do
        @user=FactoryGirl.build(:user,name:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @user.valid?
        expect(@user.errors.details).to include (:name)
      end
    end
    context "Name Too Short" do
      before :each do
        @user=FactoryGirl.build(:user,name:"ss")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @user.valid?
        expect(@user.errors.details).to include (:name)
      end
    end
    context "Name Too Long" do
      before :each do
        @user=FactoryGirl.build(:user,name:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on name field" do
        @user.valid?
        expect(@user.errors.details).to include (:name)
      end
    end
  end
  describe ":lastname" do
    context "lastname Null" do
      before :each do
        @user=FactoryGirl.build(:user,lastname:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on lastname field" do
        @user.valid?
        expect(@user.errors.details).to include (:lastname)
      end
    end
    context "lastname Blank" do
      before :each do
        @user=FactoryGirl.build(:user,lastname:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on lastname field" do
        @user.valid?
        expect(@user.errors.details).to include (:lastname)
      end
    end
    context "lastname Too Short" do
      before :each do
        @user=FactoryGirl.build(:user,lastname:"ss")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on lastname field" do
        @user.valid?
        expect(@user.errors.details).to include (:lastname)
      end
    end
    context "lastname Too Long" do
      before :each do
        @user=FactoryGirl.build(:user,lastname:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on lastname field" do
        @user.valid?
        expect(@user.errors.details).to include (:lastname)
      end
    end
  end
  describe ":website" do
    context "website Null" do
      before :each do
        @user=FactoryGirl.build(:user,website:nil)
      end
      it "should pass validation" do
        expect(@user.valid?).to be (true)
      end
    end
    context "website Blank" do
      before :each do
        @user=FactoryGirl.build(:user,website:"")
      end
      it "should pass validation" do
        expect(@user.valid?).to be (true)
      end
    end
    context "website Too Short" do
      before :each do
        @user=FactoryGirl.build(:user,website:"ssss")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on website field" do
        @user.valid?
        expect(@user.errors.details).to include (:website)
      end
    end
    context "website Too Long" do
      before :each do
        @user=FactoryGirl.build(:user,website:201.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on website field" do
        @user.valid?
        expect(@user.errors.details).to include (:website)
      end
    end
  end
  describe ":doc" do
    context "doc Null" do
      before :each do
        @user=FactoryGirl.build(:user,doc:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on doc field" do
        @user.valid?
        expect(@user.errors.details).to include (:doc)
      end
    end
    context "doc blank" do
      before :each do
        @user=FactoryGirl.build(:user,doc:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on doc field" do
        @user.valid?
        expect(@user.errors.details).to include (:doc)
      end
    end
    context "doc less than 7 characters" do
      before :each do
        @user=FactoryGirl.build(:user,doc:"100000")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on doc field" do
        @user.valid?
        expect(@user.errors.details).to include (:doc)
      end
    end
    context "doc more than 11 characters" do
      before :each do
        @user=FactoryGirl.build(:user,doc:"109876543245")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on doc field" do
        @user.valid?
        expect(@user.errors.details).to include (:doc)
      end
    end
  end
  describe ":address" do
    context "address Null" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,address:nil)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:address)
      end
    end
    context "address Blank" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,address:"")
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:address)
      end
    end
    context "address Too Short (Less than 10)" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,address:9.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:address)
      end
    end
    context "address Too Long" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,address:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on address field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:address)
      end
    end
  end
  describe ":phone" do
    context "phone Null" do
      before :each do
        @user=FactoryGirl.build(:user,phone:nil)
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on phone field" do
        @user.valid?
        expect(@user.errors.details).to include (:phone)
      end
    end
    context "phone blank" do
      before :each do
        @user=FactoryGirl.build(:user,phone:"")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on phone field" do
        @user.valid?
        expect(@user.errors.details).to include (:phone)
      end
    end
    context "phone less than 7 characters" do
      before :each do
        @user=FactoryGirl.build(:user,phone:"100000")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on phone field" do
        @user.valid?
        expect(@user.errors.details).to include (:phone)
      end
    end
    context "phone more than 10 characters" do
      before :each do
        @user=FactoryGirl.build(:user,phone:"10000000000")
      end
      it "should not pass validation" do
        expect(@user.valid?).to be (false)
      end
      it "should contain an error on phone field" do
        @user.valid?
        expect(@user.errors.details).to include (:phone)
      end
    end
  end

  describe ".regenerate_password" do
    before :each do
        @password = Devise.friendly_token.first(8)
        @user=FactoryGirl.create(:user,password:@password)
      end
      it "should change user password" do
      @user.regenerate_password
      expect(@user.password).not_to eq(@password)  
      expect(@user.password_confirmation).not_to eq(@password)  
      end
  end
end
