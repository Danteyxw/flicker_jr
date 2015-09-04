get "/login" do
  erb :login
end

post "/login" do
  username = params[:username]
  password = params[:password]
  user = User.find_by(username: username)

  unless (user.nil?)
    if (password == user.password)
      @user = user
      session[:user] = username
      url = "/profile/#{username}"
    else
      error = "incorrect password."
      url = "/login?#{error}"
    end
  else
    error = "user does not exist."
    url = "/login?#{error}"
  end
  redirect url
end

post "/signup" do
  username = params[:username]
  password = params[:password]
  email = params[:email]
  fullname = params[:fullname]

  user = User.new(username: username, password: password, email: email, fullname: fullname)

  if (user.valid?)
    user.save
    session[:user] = username
    url = "/profile/#{username}"
  else
    error = "Either the user already exist, or you missed some data."
    url = "login?#{error}"
  end
  redirect url
end

get "/logout" do
  session[:user] = nil

  redirect "/"
end