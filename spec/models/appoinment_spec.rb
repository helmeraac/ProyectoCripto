require 'rails_helper'
RSpec.describe Appointment do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @appointment=FactoryGirl.build(:appointment)
      end
      it "should pass validation" do
        expect(@appointment.valid?).to be (true)
      end
    end
  end

  describe ":date" do
    context "Date Null" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,date:nil)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on date field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:date)
      end
    end
    context "Date Blank" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,date:"")
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on date field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:date)
      end
    end
    context "Past Date" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,date:Time.now - 10.minutes)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on date field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:date)
      end
    end
  end

  describe ":duration" do
    context "Duration Null" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,duration:nil)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on duration field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:duration)
      end
    end
    context "Duration Not a Number" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,duration:"a")
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on duration field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:duration)
      end
    end
    context "Duration less than 15" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,duration:14)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on duration field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:duration)
      end
    end
    context "Duration more than 90" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,duration:91)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on duration field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:duration)
      end
    end
    context "Duration not integer" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,duration:10.2)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on duration field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:duration)
      end
    end
  end

  describe ":lab" do
    context "lab Null" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,lab:nil)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on lab field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:lab)
      end
    end
  end
  describe ":user" do
    context "User Null" do
      before :each do
        @appointment=FactoryGirl.build(:appointment,user:nil)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on user field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:user)
      end
    end
  end
end
