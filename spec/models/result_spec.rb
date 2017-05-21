require 'rails_helper'
RSpec.describe Result do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @result=FactoryGirl.build(:result)
      end
      it "should pass validation" do
        expect(@result.valid?).to be (true)
      end
    end
  end
  describe ":upload_date" do
    context "upload_date Null" do
      before :each do
        @result=FactoryGirl.build(:result,upload_date:nil)
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on upload_date field" do
        @result.valid?
        expect(@result.errors.details).to include (:upload_date)
      end
    end
    context "upload_date Blank" do
      before :each do
        @result=FactoryGirl.build(:result,upload_date:"")
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on upload_date field" do
        @result.valid?
        expect(@result.errors.details).to include (:upload_date)
      end
    end
    context "Future upload_date" do
      before :each do
        @result=FactoryGirl.build(:result,upload_date:Time.now + 10.seconds)
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on upload_date field" do
        @result.valid?
        expect(@result.errors.details).to include (:upload_date)
      end
    end
  end
  describe ":comment" do
    context "comment Null" do
      before :each do
        @result=FactoryGirl.build(:result,comment:nil)
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on comment field" do
        @result.valid?
        expect(@result.errors.details).to include (:comment)
      end
    end
    context "comment Blank" do
      before :each do
        @result=FactoryGirl.build(:result,comment:"")
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on comment field" do
        @result.valid?
        expect(@result.errors.details).to include (:comment)
      end
    end
    context "comment Too Short" do
      before :each do
        @result=FactoryGirl.build(:result,comment:"ss")
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on comment field" do
        @result.valid?
        expect(@result.errors.details).to include (:comment)
      end
    end
    context "comment Too Long" do
      before :each do
        @result=FactoryGirl.build(:result,comment:1001.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on comment field" do
        @result.valid?
        expect(@result.errors.details).to include (:comment)
      end
    end
  end
  describe ":file_path" do
    context "file_path Null" do
      before :each do
        @result=FactoryGirl.build(:result,file_path:nil)
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on file_path field" do
        @result.valid?
        expect(@result.errors.details).to include (:file_path)
      end
    end
    context "file_path Blank" do
      before :each do
        @result=FactoryGirl.build(:result,file_path:"")
      end
      it "should not pass validation" do
        expect(@result.valid?).to be (false)
      end
      it "should contain an error on file_path field" do
        @result.valid?
        expect(@result.errors.details).to include (:file_path)
      end
    end

  end
  describe ":user" do
    context "user Null" do
      before :each do
        @appointment=FactoryGirl.build(:result,user:nil)
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
