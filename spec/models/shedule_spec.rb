require 'rails_helper'
RSpec.describe Shedule do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @shedule=FactoryGirl.build(:shedule)
      end
      it "should pass validation" do
        expect(@shedule.valid?).to be (true)
      end
    end
  end
  describe ":weekdays" do
    context "weekdays Null" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,weekdays:nil)
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on weekdays field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:weekdays)
      end
    end
    context "weekdays Blank" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,weekdays:"")
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on weekdays field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:weekdays)
      end
    end
    context "weekdays Too Short" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,weekdays:"s")
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on weekdays field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:weekdays)
      end
    end
    context "weekdays Too Long" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,weekdays:251.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on weekdays field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:weekdays)
      end
    end
  end
  describe ":hours_per_day" do
    context "hours_per_day Null" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,hours_per_day:nil)
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on hours_per_day field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:hours_per_day)
      end
    end
    context "hours_per_day Blank" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,hours_per_day:"")
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on hours_per_day field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:hours_per_day)
      end
    end
    context "hours_per_day Too Short" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,hours_per_day:"s")
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on hours_per_day field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:hours_per_day)
      end
    end
    context "hours_per_day Too Long" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,hours_per_day:2001.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on hours_per_day field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:hours_per_day)
      end
    end
  end
  describe ":lab" do
    context "lab Null" do
      before :each do
        @shedule=FactoryGirl.build(:shedule,lab:nil)
      end
      it "should not pass validation" do
        expect(@shedule.valid?).to be (false)
      end
      it "should contain an error on lab field" do
        @shedule.valid?
        expect(@shedule.errors.details).to include (:lab)
      end
    end
  end
end
