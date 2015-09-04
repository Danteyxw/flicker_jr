class PhotoUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    'images'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end