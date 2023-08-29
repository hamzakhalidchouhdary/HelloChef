# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_11_115125) do

  create_table "bills", force: :cascade do |t|
    t.float "amount"
    t.string "month"
    t.boolean "is_paid"
    t.float "discount"
    t.integer "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_bills_on_organization_id"
  end

  create_table "items", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "staff_id"
    t.string "title"
    t.text "description"
    t.float "price"
    t.string "currency"
    t.string "icon"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shop_id"], name: "index_items_on_shop_id"
    t.index ["staff_id"], name: "index_items_on_staff_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "shop_id"
    t.integer "organization_id"
    t.integer "staff_id"
    t.float "amount"
    t.float "discount"
    t.float "paid_ammount"
    t.string "table_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_orders_on_organization_id"
    t.index ["shop_id"], name: "index_orders_on_shop_id"
    t.index ["staff_id"], name: "index_orders_on_staff_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "account_type"
    t.string "address"
    t.string "status"
    t.string "contact_no"
    t.string "email"
    t.integer "shop_limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.string "currency"
    t.string "price_type"
    t.float "price"
    t.integer "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_pricings_on_organization_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_shops_on_organization_id"
  end

  create_table "staffs", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "role"
    t.string "organization_id"
    t.string "shop_id"
    t.string "name"
    t.integer "salary"
    t.string "contact"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.integer "organization_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

end
