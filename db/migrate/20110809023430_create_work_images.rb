class CreateWorkImages < ActiveRecord::Migration
  def change
    create_table :work_images do |t|
      t.belongs_to  :work
      t.string      :image
      t.timestamps
    end
  end
end
