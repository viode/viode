# frozen_string_literal: true

require 'carrierwave/processing/mini_magick'

class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  MiniMagick.processor = :gm if ViodeSettings.image_processor == 'GraphicsMagick'

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :strip_data
  process resize_to_fill_space: [250, 250]

  version :thumb do
    process resize_to_fill_space: [80, 80]
  end

  def extension_white_list
    %w[jpg jpeg gif png]
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

  # resize to fill a given space
  # https://gist.github.com/NARKOZ/4294977
  def resize_to_fill_space(width, height)
    manipulate! do |image|
      MiniMagick::Tool::Convert.new do |convert|
        convert << image.path
        convert.resize "#{width}x#{height}^"
        convert.gravity 'center'
        convert.extent "#{width}x#{height}"
        convert << image.path
      end

      image
    end
  end

  # timestamp for use in file names
  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) || model.instance_variable_set(var, Time.current.to_i)
  end
end
