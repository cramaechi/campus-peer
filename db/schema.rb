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

ActiveRecord::Schema.define(:version => 20120621183918) do

  create_table "book_transactions", :force => true do |t|
    t.integer  "sell_book_item_id"
    t.integer  "book_id"
    t.integer  "seller_user_id"
    t.integer  "buyer_user_id"
    t.integer  "campus_id"
    t.decimal  "price",                 :precision => 5, :scale => 2
    t.string   "condition"
    t.string   "condition_description"
    t.string   "peertag"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "isbn10"
    t.string   "isbn13"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.decimal  "pricenew",   :precision => 5, :scale => 2
    t.decimal  "priceused",  :precision => 5, :scale => 2
    t.string   "category"
  end

  add_index "books", ["isbn10"], :name => "index_books_on_isbn10", :unique => true
  add_index "books", ["isbn13"], :name => "index_books_on_isbn13", :unique => true

  create_table "campus", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "city"
    t.string   "state"
  end

  create_table "most_wanted_books", :force => true do |t|
    t.integer  "book_id"
    t.integer  "campus_id"
    t.integer  "want"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sell_book_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.integer  "campus_id"
    t.decimal  "price",                 :precision => 5, :scale => 2
    t.string   "condition"
    t.string   "condition_description"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "campus_id"
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
