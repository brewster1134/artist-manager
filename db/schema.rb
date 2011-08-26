# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110825230239) do

  create_table "series", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "view"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "media"
    t.string   "video_link"
    t.string   "dimensions"
    t.integer  "completion_year"
    t.boolean  "for_sale",          :default => false
    t.integer  "price_cents",       :default => 0
    t.string   "price_currency",    :default => "usd"
    t.integer  "quantity",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "series_id"
    t.string   "view"
    t.boolean  "featured",          :default => false
    t.integer  "shipping_cents",    :default => 0
    t.string   "shipping_currency", :default => "usd"
  end

  create_table "work_images", :force => true do |t|
    t.integer  "work_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
