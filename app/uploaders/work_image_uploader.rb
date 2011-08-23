# encoding: utf-8

class WorkImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  # include CarrierWave::RMagick
  # include CarrierWave::ImageScience
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/work/#{model.work.title.parameterize}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  process :resize_to_fit => [1920, 1080]

  def resize_by_height(height)
    manipulate! do |img|
      img.resize "x#{height}"
      img = yield(img) if block_given?
      img
    end
  end

  # home#show accordion
  version :home_show_series do
    process :resize_to_fill => Settings.image_sizes[:home][:show][:series]
  end
  version :home_show_work do
    process :resize_to_fill => Settings.image_sizes[:home][:show][:work]
  end

  # series#show
  version :series_show_work do
    process :resize_to_fill => Settings.image_sizes[:series][:show][:work]
  end
  version :series_show_slideshow do
    process :resize_to_fill => Settings.image_sizes[:series][:show][:slideshow]
  end
  version :series_show_image_scroller do
    process :resize_by_height => Settings.image_sizes[:series][:show][:image_scroller_height]
  end

  # work#edit
  version :work_edit do
    process :resize_and_pad => Settings.image_sizes[:work][:edit]
  end

  # work#index
  version :work_index_series do
    process :resize_to_fill => Settings.image_sizes[:work][:index][:series]
  end
  version :work_index_work do
    process :resize_to_fill => Settings.image_sizes[:work][:index][:work]
  end

  # work#show
  version :work_show_slideshow do
    process :resize_to_fill => Settings.image_sizes[:work][:show][:slideshow]
  end
  version :work_show_image_scroller do
    process :resize_by_height => Settings.image_sizes[:work][:show][:image_scroller_height]
  end
  version :work_show_plain do
    process :resize_to_fill => Settings.image_sizes[:work][:show][:plain]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
