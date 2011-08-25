class WorkImage < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :work
  mount_uploader :image, WorkImageUploader

  def to_jq_upload
    {
      "name" =>           read_attribute(:image),
      "size" =>           self.image.size,
      "url" =>            self.image.url,
      "thumbnail_path" => self.image.work_edit_work.url,
      "delete_path" =>    work_image_path(id),
      "delete_type" =>    "DELETE", 
      "work_id" =>        self.work.url
     }
  end
end
