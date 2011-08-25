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

  @@sizes = Settings.image_sizes

  # home#splash page
  version :home_splash_slideshow do
    size = @@sizes[:home][:splash][:slideshow]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :home_splash_random do
    size = @@sizes[:home][:splash][:random]
    process :resize_to_fill => [size[:width], size[:height]]
  end

  # home#show accordion
  version :home_show_series do
    size = @@sizes[:home][:show][:series]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :home_show_work do
    size = @@sizes[:home][:show][:work]
    process :resize_to_fill => [size[:width], size[:height]]
  end

  # series#show
  version :series_show_work do
    size = @@sizes[:series][:show][:work]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :series_show_slideshow do
    size = @@sizes[:series][:show][:slideshow]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :series_show_scroller do
    process :resize_by_height => @@sizes[:series][:show][:scroller][:height]
  end

  # work#edit
  version :work_edit_work do
    size = @@sizes[:work][:edit][:work]
    process :resize_and_pad => [size[:width], size[:height]]
  end

  # work#index
  version :work_index_series do
    size = @@sizes[:work][:index][:series]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :work_index_work do
    size = @@sizes[:work][:index][:work]
    process :resize_to_fill => [size[:width], size[:height]]
  end

  # work#show
  version :work_show_slideshow do
    size = @@sizes[:work][:show][:slideshow]
    process :resize_to_fill => [size[:width], size[:height]]
  end
  version :work_show_scroller do
    process :resize_by_height => @@sizes[:work][:show][:scroller][:height]
  end
  version :work_show_plain do
    size = @@sizes[:work][:show][:plain]
    process :resize_to_fill => [size[:width], size[:height]]
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
