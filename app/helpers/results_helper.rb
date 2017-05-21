module ResultsHelper
  def user_result_list(result_list_params)
    @user = User.find(result_list_params[:user_id])
    @user_results = Result.for_user(result_list_params[:user_id])
  end
end
