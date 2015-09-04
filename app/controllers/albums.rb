get "/albums/create" do
  erb :create
end

get "/albums/:album_id" do
  @album = Album.find(params[:album_id])

  erb :album
end

post "/albums/create" do
  title = params[:title]
  description = params[:description]
  user = User.find_by(username: session[:user])

  album = user.albums.create(title: title, description: description)

  redirect "/albums/#{album.id}"
end

get "/albums/:album_id/delete" do
  @album = Album.find(params[:album_id])

  erb :delete
end

post "/albums/:album_id/delete" do
  album = Album.find(params[:album_id])
  user = User.find_by(username: session[:user])
  password = params[:password]

  if (user.password == password)
    album.delete
    url = "/profile/#{user.username}"
  else
    error = "incorrect password."
    url = "/albums/:album_id/delete?error=#{error}"
  end
  redirect url
end