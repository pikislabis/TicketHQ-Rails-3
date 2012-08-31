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

ActiveRecord::Schema.define(:version => 20120831234113) do

  create_table "attaches", :force => true do |t|
    t.integer  "record_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.boolean  "upgrade"
    t.boolean  "remove"
    t.boolean  "make"
    t.boolean  "observe"
    t.boolean  "view"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups_projects", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "project_id"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "labels", :force => true do |t|
    t.integer  "ticket_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_subscribes", :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "info"
    t.boolean  "closed",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "records", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.text     "text1"
    t.text     "text2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.integer  "position"
    t.boolean  "close",      :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "ticket_relationships", :force => true do |t|
    t.integer  "ticket_id"
    t.integer  "ticket_o_id"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ticket_subscribes", :force => true do |t|
    t.integer "user_id"
    t.integer "ticket_id"
  end

  create_table "tickets", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "origin"
    t.integer  "user_id"
    t.integer  "status_id",   :limit => 255
    t.string   "priority"
    t.string   "type_inc"
    t.integer  "assigned_to"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "project_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                   :default => "",           :null => false
    t.string   "encrypted_password",      :default => "",           :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "username"
    t.string   "name"
    t.boolean  "admin"
    t.boolean  "enabled"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "notification_preference", :default => "inmediatly"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
