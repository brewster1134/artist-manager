class AddShippingToWork < ActiveRecord::Migration
  def change
    add_column :work, :shipping_cents, :integer, :default => 0 
    add_column :work, :shipping_currency, :string, :default => :usd 
  end
end
