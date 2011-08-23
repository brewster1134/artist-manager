class AddFeaturedAndViewsToSeriesAndWork < ActiveRecord::Migration
  def change
    add_column :series, :view, :string
    add_column :work,   :view, :string
    add_column :work,   :featured, :boolean
  end
end
