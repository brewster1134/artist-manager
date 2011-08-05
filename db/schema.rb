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

ActiveRecord::Schema.define(:version => 20110802230817) do

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
    t.boolean  "for_sale",        :default => true
    t.integer  "price_cents",     :default => 0
    t.string   "price_currency",  :default => "usd"
    t.integer  "quantity",        :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
