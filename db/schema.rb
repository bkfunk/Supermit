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

ActiveRecord::Schema.define(:version => 20120318211618) do

  create_table "todos", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "desc"
    t.integer  "parent_id"
    t.datetime "due_at"
    t.boolean  "has_time_due"
    t.integer  "journal_id"
    t.integer  "story_id"
    t.boolean  "is_complete"
    t.datetime "completed_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "todos", ["due_at", "parent_id", "id"], :name => "index_todos_on_due_at_and_parent_id_and_id"
  add_index "todos", ["journal_id", "due_at"], :name => "index_todos_on_journal_id_and_due_at"
  add_index "todos", ["story_id", "due_at"], :name => "index_todos_on_story_id_and_due_at"
  add_index "todos", ["user_id", "due_at"], :name => "index_todos_on_user_id_and_due_at"

  create_table "users", :force => true do |t|
    t.string   "identifier_url"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
