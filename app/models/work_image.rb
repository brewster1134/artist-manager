class WorkImage < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :work
  mount_uploader :image, WorkImageUploader

  def to_jq_upload
    {
      "name" =>           read_attribute(:image),
      "size" =>           self.image.size,
      "url" =>            self.image.url,
      "thumbnail_url" =>  self.image.upload.url,
      "delete_url" =>     image_path(id),
      "delete_type" =>    "DELETE" 
     }
  end
end
