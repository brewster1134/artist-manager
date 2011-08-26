class CreateWork < ActiveRecord::Migration
  def change
    create_table :work do |t|
      t.string  :title
      t.text    :description
      t.string  :media
      t.string  :video_link
      t.string  :dimensions
      t.integer :completion_year
      t.boolean :for_sale,        :default => false
      t.integer :price_cents,     :default => 0
      t.string  :price_currency,  :default => :usd
      t.integer :quantity,        :default => 0
      t.timestamps
    end
  end
end
