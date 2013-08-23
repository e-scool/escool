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

ActiveRecord::Schema.define(:version => 20130823190834) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "children", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "parent_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "children", ["classroom_id"], :name => "index_children_on_classroom_id"
  add_index "children", ["parent_id"], :name => "index_children_on_parent_id"
  add_index "children", ["school_id"], :name => "index_children_on_school_id"

  create_table "children_communications", :id => false, :force => true do |t|
    t.integer "child_id"
    t.integer "communication_id"
  end

  create_table "children_daily_activities", :id => false, :force => true do |t|
    t.integer "child_id"
    t.integer "daily_activity_id"
  end

  create_table "children_materials", :id => false, :force => true do |t|
    t.integer "child_id"
    t.integer "material_id"
  end

  create_table "classroom_types", :force => true do |t|
    t.integer "school_id"
    t.string  "name"
    t.boolean "materials",        :default => false
    t.boolean "communications",   :default => false
    t.boolean "lunch_reports",    :default => false
    t.boolean "daily_activities", :default => false
  end

  add_index "classroom_types", ["school_id"], :name => "index_classroom_types_on_school_id"

  create_table "classrooms", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "classroom_type_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "classrooms", ["school_id"], :name => "index_classrooms_on_school_id"

  create_table "classrooms_teachers", :id => false, :force => true do |t|
    t.integer "classroom_id"
    t.integer "teacher_id"
  end

  create_table "communications", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "date"
    t.integer  "classroom_id"
    t.integer  "subject_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "communications", ["classroom_id"], :name => "index_communications_on_classroom_id"

  create_table "daily_activities", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "date"
    t.integer  "classroom_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "daily_activities", ["classroom_id"], :name => "index_daily_activities_on_classroom_id"

  create_table "lunch_reports", :force => true do |t|
    t.integer  "status"
    t.datetime "date"
    t.integer  "child_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "lunch_reports", ["child_id"], :name => "index_lunch_reports_on_child_id"
  add_index "lunch_reports", ["classroom_id"], :name => "index_lunch_reports_on_classroom_id"

  create_table "materials", :force => true do |t|
    t.string   "title"
    t.datetime "date"
    t.integer  "classroom_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "body"
    t.integer  "subject_id"
  end

  add_index "materials", ["classroom_id"], :name => "index_materials_on_classroom_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "classroom_id"
    t.integer  "teacher_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "subjects", ["classroom_id"], :name => "index_subjects_on_classroom_id"
  add_index "subjects", ["teacher_id"], :name => "index_subjects_on_teacher_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "school_id",                              :null => false
    t.string   "type",                                   :null => false
    t.string   "name",                                   :null => false
    t.string   "username",                               :null => false
    t.integer  "current_child_id"
    t.integer  "current_classroom_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

end
