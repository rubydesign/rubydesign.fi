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

ActiveRecord::Schema.define(version: 2019_10_17_155313) do

  create_table "baskets", force: :cascade do |t|
    t.integer "kori_id"
    t.string "kori_type", limit: 255
    t.decimal "total_price", default: "0.0"
    t.decimal "total_tax", default: "0.0"
    t.date "locked"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "kind"
    t.index ["kori_id"], name: "index_baskets_on_kori_id"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "category_id"
    t.string "name", limit: 255
    t.text "description", default: ""
    t.text "summary", default: ""
    t.integer "position", default: 1
    t.string "main_picture_file_name", limit: 255
    t.string "main_picture_content_type", limit: 255
    t.integer "main_picture_file_size"
    t.datetime "main_picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "deleted_on"
    t.index ["category_id"], name: "index_categories_on_category_id"
  end

  create_table "clerks", force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.boolean "admin", default: false
    t.string "encrypted_password", limit: 255
    t.string "password_salt", limit: 255
    t.string "address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_clerks_on_email", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.float "price", default: 0.0
    t.float "tax", default: 0.0
    t.string "name", limit: 255
    t.integer "product_id"
    t.integer "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["basket_id"], name: "index_items_on_basket_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "number", limit: 255
    t.string "email", limit: 255
    t.date "ordered_on"
    t.date "paid_on"
    t.date "canceled_on"
    t.date "shipped_on"
    t.string "payment_type", limit: 255
    t.string "payment_info", limit: 255
    t.string "shipment_type", limit: 255
    t.string "shipment_info", limit: 255
    t.float "shipment_price", default: 0.0
    t.float "shipment_tax", default: 0.0
    t.string "address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "note", limit: 255, default: ""
    t.string "message"
    t.integer "order_number"
  end

  create_table "products", force: :cascade do |t|
    t.float "price", null: false
    t.string "name", limit: 255, null: false
    t.text "description", default: ""
    t.text "summary", default: ""
    t.float "cost", default: 0.0
    t.float "weight", default: 0.1
    t.string "ean", limit: 255, default: ""
    t.float "tax", default: 0.0
    t.integer "inventory", default: 0
    t.integer "stock_level", default: 0
    t.string "properties", limit: 255, default: ""
    t.string "scode", limit: 255, default: ""
    t.date "deleted_on"
    t.integer "category_id"
    t.integer "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position", default: 1
    t.integer "pack_unit"
    t.integer "phase", default: 1
    t.integer "dimension", default: 1
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["supplier_id"], name: "index_products_on_supplier_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.string "name", limit: 255
    t.date "ordered_on"
    t.date "received_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "supplier_id"
    t.index ["supplier_id"], name: "index_purchases_on_supplier_id"
  end

  create_table "resellers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "post_code"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "supplier_name", limit: 255
    t.string "address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "deleted_on"
  end

end
