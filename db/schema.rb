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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131226151332) do

  create_table "addresses", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "street1"
    t.string   "street2"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "baskets", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "quantity"
    t.float    "price"
    t.float    "tax"
    t.integer  "product_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.date     "ordered_on"
    t.float    "total_price"
    t.float    "total_tax"
    t.float    "shipping_price"
    t.float    "shipping_tax"
    t.integer  "basket_id"
    t.string   "email"
    t.date     "paid_on"
    t.date     "shipped_on"
    t.date     "canceled_on"
    t.string   "shipment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "description"
    t.integer  "position",                   default: 1
    t.string   "link"
    t.string   "main_picture_file_name"
    t.string   "main_picture_content_type"
    t.integer  "main_picture_file_size"
    t.datetime "main_picture_updated_at"
    t.string   "extra_picture_file_name"
    t.string   "extra_picture_content_type"
    t.integer  "extra_picture_file_size"
    t.datetime "extra_picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.float    "price"
    t.string   "main_picture_file_name"
    t.string   "main_picture_content_type"
    t.integer  "main_picture_file_size"
    t.datetime "main_picture_updated_at"
    t.string   "extra_picture_file_name"
    t.string   "extra_picture_content_type"
    t.integer  "extra_picture_file_size"
    t.datetime "extra_picture_updated_at"
    t.float    "cost",                       default: 0.0
    t.float    "weight",                     default: 0.1
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.string   "ean"
    t.float    "tax"
    t.integer  "inventory",                  default: 0
    t.string   "properties"
    t.string   "scode"
    t.date     "deleted_on"
    t.integer  "product_id"
    t.integer  "category_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"
  add_index "products", ["product_id"], name: "index_products_on_product_id"
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id"

  create_table "purchases", force: true do |t|
    t.string   "name"
    t.date     "ordered_on"
    t.date     "received_on"
    t.integer  "basket_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchases", ["basket_id"], name: "index_purchases_on_basket_id"

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.integer  "basket_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
