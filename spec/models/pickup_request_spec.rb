require 'rails_helper'
RSpec.describe PickupRequest do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request)
      end
      it "should pass validation" do
        expect(@pickup_request.valid?).to be (true)
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
  describe ":latitude" do
    context "Latitude as a decimal number" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,latitude:-89.5)
      end
      it "should pass validation" do
        expect(@pickup_request.valid?).to be (true)
      end
    end
    context "Latitude Null" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,latitude:nil)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on latitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:latitude)
      end
    end
    context "Latitude less than -90" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,latitude:-91)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on latitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:latitude)
      end
    end
    context "Latitude more than 90" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,latitude:91)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on latitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:latitude)
      end
    end
  end
  describe ":longitude" do
    context "longitude as a decimal number" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,longitude:-89.5)
      end
      it "should pass validation" do
        expect(@pickup_request.valid?).to be (true)
      end
    end
    context "longitude Null" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,longitude:nil)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on longitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:longitude)
      end
    end
    context "longitude less than -180" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,longitude:-181)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on longitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:longitude)
      end
    end
    context "longitude more than 180" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,longitude:181)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on longitude field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:longitude)
      end
    end
  end

  describe ":status" do
    context "status as a decimal number" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,status:-89.5)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on status field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:status)
      end
    end
    context "status Null" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,status:nil)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on status field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:status)
      end
    end
    context "status less than 0" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,status:-1)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on status field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:status)
      end
    end
    context "status more than 2" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,status:3)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on status field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:status)
      end
    end
  end
  describe ":user" do
    context "User Null" do
      before :each do
        @pickup_request=FactoryGirl.build(:pickup_request,user:nil)
      end
      it "should not pass validation" do
        expect(@pickup_request.valid?).to be (false)
      end
      it "should contain an error on user field" do
        @pickup_request.valid?
        expect(@pickup_request.errors.details).to include (:user)
      end
    end
  end
end
