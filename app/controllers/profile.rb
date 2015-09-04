get "/profile/:username" do
  @user = User.find_by(username: params[:username])

  erb :profile
end