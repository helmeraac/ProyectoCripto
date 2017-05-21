require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ResultsController, type: :controller do

  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    @sign_in_admin = FactoryGirl.create(:admin)
    sign_in @sign_in_admin # Using factory girl as an example
    @user = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user)
  end
  # This should return the minimal set of attributes required to create a valid
  # Result. As you add validations to Result, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      upload_date: Time.now - 10.minutes,
      comment:"A User Result from test",
      # file_path: File.open(File.join(Rails.root, '/spec/test.pdf')),
      file_path: Rack::Test::UploadedFile.new(File.join(Rails.root, '/spec/test.pdf')),
      user_id: @user.id
    }
  }

  let(:invalid_attributes) {
    {
      upload_date: Time.now + 10.minutes,
      comment:"",
      file_path: "/users/path/to/the/file.jpg",
      user_id: @user.id
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ResultsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all results as @results" do
      result = Result.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:results)).to eq([result])
    end
  end

  describe "GET #list" do
    before :each do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @sign_in_user = FactoryGirl.create(:user)
      sign_in @sign_in_user
    end
    it "assigns user results as @user_results" do
      result = Result.create! valid_attributes
      valid_attributes[:user_id] = @user2.id
      Result.create! valid_attributes
      get :list, params: {user_id:@user.id}, session: valid_session
      expect(assigns(:user_results)).to eq([result])
    end
  end



  describe "POST #create" do
    context "with valid params" do
      it "creates a new Result" do
        expect {
          post :create, params: {result: valid_attributes}, session: valid_session
        }.to change(Result, :count).by(1)

      end

      it "assigns a newly created result as @result" do
        post :create, params: {result: valid_attributes}, session: valid_session
        expect(assigns(:result)).to be_a(Result)
        expect(assigns(:result)).to be_persisted
      end

      it "return 200 status and a json with success message" do
        post :create, params: {result: valid_attributes}, session: valid_session
        expect(response.status).to be(200)
        expect(response.body).to include('success')

      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved result as @result" do
        post :create, params: {result: invalid_attributes}, session: valid_session
        expect(assigns(:result)).to be_a_new(Result)
      end

      it "return 400 status and a json with errors message" do
        post :create, params: {result: invalid_attributes}, session: valid_session
        expect(response.status).to be(400)
        expect(response.body).to include('errors')
      end
    end
  end


  describe "DELETE #destroy" do
    it "destroys the requested result" do
      result = Result.create! valid_attributes
      expect {
        delete :destroy, params: {id: result.to_param}, session: valid_session
      }.to change(Result, :count).by(-1)
    end

    it "returns 200 status and returns a success message" do
      result = Result.create! valid_attributes
      delete :destroy, params: {id: result.to_param}, session: valid_session
      expect(response.status).to be(200)
      expect(response.body).to include('success')
    end
  end

  describe "GET #download_file" do
    context "Logged Admin" do
      it "download the file and return 200 status" do
        result = Result.create! valid_attributes
        expect(@controller).to receive(:send_file).with(result.file_path.path,status: 200) {@controller.render :nothing => true}
        get :download_file,params: {result_id: result.to_param}, session: valid_session
        expect(response.status).to be(200)
      end
    end
    context "Logged User (Result Owner)" do
      before :each do
        sign_out @sign_in_admin
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @sign_in_user = @user
        sign_in @sign_in_user # Using factory girl as an example
      end
      it "download the file and return 200 status" do
        result = Result.create! valid_attributes
        expect(@controller).to receive(:send_file).with(result.file_path.path,status: 200) {@controller.render :nothing => true}
        get :download_file,params: {result_id: result.to_param}, session: valid_session
        expect(response.status).to be(200)
      end
    end
    context "Logged User (Not Result Owner)" do
      before :each do
        sign_out @sign_in_admin
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @sign_in_user = FactoryGirl.create(:user)
        sign_in @sign_in_user # Using factory girl as an example
      end
      it "returns 401 status and error" do
        result = Result.create! valid_attributes
        get :download_file,params: {result_id: result.to_param}, session: valid_session
        expect(response.status).to be(401)
        expect(response.body).to include('error')
      end
    end
    context "Not Logged User or Admin" do
      before :each do
        sign_out @sign_in_admin
      end
      it "returns 401 status and error" do
        result = Result.create! valid_attributes
        get :download_file,params: {result_id: result.to_param}, session: valid_session
        expect(response.status).to be(401)
        expect(response.body).to include('error')
      end
    end
  end
end
