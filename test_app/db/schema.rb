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

ActiveRecord::Schema.define(version: 20171225183213) do

  create_table "baskets", force: :cascade do |t|
    t.integer  "kori_id"
    t.string   "kori_type"
    t.decimal  "total_price", default: "0.0"
    t.decimal  "total_tax",   default: "0.0"
    t.date     "locked"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "category_id"
    t.boolean  "online",                    default: false
    t.string   "name"
    t.text     "description"
    t.text     "summary"
    t.integer  "position",                  default: 1
    t.string   "link"
    t.string   "main_picture_file_name"
    t.string   "main_picture_content_type"
    t.integer  "main_picture_file_size"
    t.datetime "main_picture_updated_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.date     "deleted_on"
    t.index ["link"], name: "index_categories_on_link", unique: true
  end

  create_table "clerks", force: :cascade do |t|
    t.string   "email",              default: "",    null: false
    t.boolean  "admin",              default: false
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_clerks_on_email", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer  "quantity",   default: 1
    t.float    "price",      default: 0.0
    t.float    "tax",        default: 0.0
    t.string   "name"
    t.integer  "product_id"
    t.integer  "basket_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "number"
    t.string   "note",           default: ""
    t.string   "email"
    t.date     "ordered_on"
    t.date     "paid_on"
    t.date     "canceled_on"
    t.date     "shipped_on"
    t.string   "payment_type"
    t.string   "payment_info"
    t.string   "shipment_type"
    t.string   "shipment_info"
    t.float    "shipment_price", default: 0.0
    t.float    "shipment_tax",   default: 0.0
    t.string   "address"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "products", force: :cascade do |t|
    t.float    "price",                                     null: false
    t.string   "name",                                      null: false
    t.string   "link"
    t.text     "description"
    t.text     "summary"
    t.string   "main_picture_file_name"
    t.string   "main_picture_content_type"
    t.integer  "main_picture_file_size"
    t.datetime "main_picture_updated_at"
    t.boolean  "online",                    default: false
    t.float    "cost",                      default: 0.0
    t.float    "weight",                    default: 0.1
    t.string   "ean",                       default: ""
    t.float    "tax",                       default: 0.0
    t.integer  "inventory",                 default: 0
    t.integer  "stock_level",               default: 0
    t.string   "properties",                default: ""
    t.string   "scode",                     default: ""
    t.date     "deleted_on"
    t.integer  "product_id"
    t.integer  "category_id"
    t.integer  "supplier_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "position",                  default: 1
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["link"], name: "index_products_on_link"
    t.index ["product_id"], name: "index_products_on_product_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "name"
    t.date     "ordered_on"
    t.date     "received_on"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "supplier_id"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "supplier_name"
    t.string   "address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
