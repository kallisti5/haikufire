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

ActiveRecord::Schema.define(:version => 20101028163058) do

  create_table "arches", :force => true do |t|
    t.string   "name"
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "downloads", :force => true do |t|
    t.integer  "software_id"
    t.integer  "arch_id"
    t.string   "dl_file_name"
    t.string   "dl_content_type"
    t.integer  "dl_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "index_simple_captcha_data_on_key"

  create_table "softwares", :force => true do |t|
    t.string   "title"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created"
    t.datetime "updated"
    t.text     "description"
    t.string   "author"
    t.string   "website"
    t.string   "version"
    t.string   "license"
    t.string   "compiled"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.string   "screenshot_file_name"
    t.string   "screenshot_content_type"
    t.integer  "screenshot_file_size"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "pass_hash"
    t.string   "pass_salt"
    t.string   "name"
    t.string   "email"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "last_login"
    t.string   "validation_hash"
    t.datetime "updated_at"
  end

end
