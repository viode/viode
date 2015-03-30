require 'carrierwave/processing/mini_magick'

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # TODO: switch to GraphicsMagick
  # MiniMagick.processor = :gm

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path([version_name, 'avatar.png'].compact.join('_'))
  end

  process :strip_data
  process resize_to_fill: [250, 250]

  version :thumb do
    process resize_to_fill: [80, 80]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    @name ||= "#{timestamp}.#{file.extension.downcase}" if original_filename
  end

  private

  # removes EXIF data
  def strip_data
    manipulate! do |image|
      image.strip
      image
    end
  end

  # timestamp for use in file names
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.current.to_i)
  end
end
