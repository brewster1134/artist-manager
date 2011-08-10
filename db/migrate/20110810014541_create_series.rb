class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.string  :title
      t.text    :description
      t.timestamps
    end
    
    add_column :work, :series_id, :integer
  end
end
