require 'rails_helper'
RSpec.describe Post do
  describe "General" do
    context "All Fields Valid (Factory Test)" do
      before :each do
        @post=FactoryGirl.build(:post)
      end
      it "should pass validation" do
        expect(@post.valid?).to be (true)
      end
    end
  end
  describe ":title" do
    context "title Null" do
      before :each do
        @post=FactoryGirl.build(:post,title:nil)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on title field" do
        @post.valid?
        expect(@post.errors.details).to include (:title)
      end
    end
    context "title Blank" do
      before :each do
        @post=FactoryGirl.build(:post,title:"")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on title field" do
        @post.valid?
        expect(@post.errors.details).to include (:title)
      end
    end
    context "title Too Short" do
      before :each do
        @post=FactoryGirl.build(:post,title:"ss")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on title field" do
        @post.valid?
        expect(@post.errors.details).to include (:title)
      end
    end
    context "title Too Long" do
      before :each do
        @post=FactoryGirl.build(:post,title:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on title field" do
        @post.valid?
        expect(@post.errors.details).to include (:title)
      end
    end
  end
  describe ":published_date" do
    context "published_date Null" do
      before :each do
        @post=FactoryGirl.build(:post,published_date:nil)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on published_date field" do
        @post.valid?
        expect(@post.errors.details).to include (:published_date)
      end
    end
    context "published_date Blank" do
      before :each do
        @post=FactoryGirl.build(:post,published_date:"")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on published_date field" do
        @post.valid?
        expect(@post.errors.details).to include (:published_date)
      end
    end
    context "Future published_date" do
      before :each do
        @post=FactoryGirl.build(:post,published_date:Time.now + 10.seconds)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on published_date field" do
        @post.valid?
        expect(@post.errors.details).to include (:published_date)
      end
    end
  end
  describe ":html_body" do
    context "html_body Null" do
      before :each do
        @post=FactoryGirl.build(:post,html_body:nil)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on html_body field" do
        @post.valid?
        expect(@post.errors.details).to include (:html_body)
      end
    end
    context "html_body Blank" do
      before :each do
        @post=FactoryGirl.build(:post,html_body:"")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on html_body field" do
        @post.valid?
        expect(@post.errors.details).to include (:html_body)
      end
    end
    context "html_body Too Short" do
      before :each do
        @post=FactoryGirl.build(:post,html_body:"sss")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on html_body field" do
        @post.valid?
        expect(@post.errors.details).to include (:html_body)
      end
    end
    context "html_body Too Long" do
      before :each do
        @post=FactoryGirl.build(:post,html_body:5001.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on html_body field" do
        @post.valid?
        expect(@post.errors.details).to include (:html_body)
      end
    end
  end
  describe ":header_img" do
    context "header_img Null" do
      before :each do
        @post=FactoryGirl.build(:post,header_img:nil)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on header_img field" do
        @post.valid?
        expect(@post.errors.details).to include (:header_img)
      end
    end
    context "header_img Blank" do
      before :each do
        @post=FactoryGirl.build(:post,header_img:"")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on header_img field" do
        @post.valid?
        expect(@post.errors.details).to include (:header_img)
      end
    end
    context "header_img Too Short" do
      before :each do
        @post=FactoryGirl.build(:post,header_img:"ss")
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on header_img field" do
        @post.valid?
        expect(@post.errors.details).to include (:header_img)
      end
    end
    context "header_img Too Long" do
      before :each do
        @post=FactoryGirl.build(:post,header_img:151.times.map {'a'}.join)
      end
      it "should not pass validation" do
        expect(@post.valid?).to be (false)
      end
      it "should contain an error on header_img field" do
        @post.valid?
        expect(@post.errors.details).to include (:header_img)
      end
    end
  end
  describe ":admin" do
    context "admin Null" do
      before :each do
        @appointment=FactoryGirl.build(:post,admin:nil)
      end
      it "should not pass validation" do
        expect(@appointment.valid?).to be (false)
      end
      it "should contain an error on admin field" do
        @appointment.valid?
        expect(@appointment.errors.details).to include (:admin)
      end
    end
  end
end
