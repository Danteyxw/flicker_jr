get "/albums/:album_id/:photo_id" do
  @photo = Photo.find(params[:photo_id])

  erb :photo
end

post "/albums/:album_id/add" do
  file =  params[:file]
  caption = params[:caption]
  album = Album.find(params[:album_id])
  user = User.find_by(username: session[:user])

  if (user == album.user)
    album.photos.create(file: file, caption: caption)
    url = "/albums/#{album.id}"
  else
    error = "you are not the owner of this album."
    url = "/albums/#{album.id}?error=#{error}"
  end
  redirect url
end

post "/albums/:album_id/:photo_id/delete" do
  user = User.find_by(username: session[:user])
  album = Album.find(params[:album_id])
  photo = Photo.find(params[:photo_id])

  if (user == album.user)
    photo.delete
    url = "/albums/#{album.id}"
  else
    error = "you are not the owner of this album."
    url = "/albums/#{album.id}?error=#{error}"
  end
  redirect url
end