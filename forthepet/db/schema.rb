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

ActiveRecord::Schema.define(version: 20150520094212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "suburb",     limit: 255
    t.string   "state",      limit: 255
    t.integer  "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1",   limit: 255
    t.string   "address2",   limit: 255
    t.integer  "user_id"
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "company",    limit: 255
    t.string   "mobile",     limit: 255
    t.string   "phone",      limit: 255
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.integer  "roles_mask"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["username"], name: "index_admins_on_username", unique: true, using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "deal_id"
    t.integer  "variant_id"
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["deal_id"], name: "index_cart_items_on_deal_id", using: :btree
  add_index "cart_items", ["variant_id"], name: "index_cart_items_on_variant_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "cart_items_count", default: 0
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "credits", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason",     limit: 255
  end

  create_table "deal_fine_prints", force: :cascade do |t|
    t.integer "deal_id"
    t.integer "fine_print_id"
  end

  add_index "deal_fine_prints", ["deal_id", "fine_print_id"], name: "index_deal_fine_prints_on_deal_id_and_fine_print_id", using: :btree

  create_table "deal_prices", force: :cascade do |t|
    t.integer  "deal_id"
    t.integer  "variant_id"
    t.decimal  "price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "percentage_saved"
  end

  add_index "deal_prices", ["deal_id"], name: "index_deal_prices_on_deal_id", using: :btree
  add_index "deal_prices", ["variant_id"], name: "index_deal_prices_on_variant_id", using: :btree

  create_table "deals", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "available_on"
    t.datetime "ends_on"
    t.boolean  "is_active",                  default: false
    t.integer  "max_quantity"
    t.string   "slug",           limit: 255
    t.integer  "purchase_limit"
    t.integer  "product_id"
    t.string   "description"
  end

  add_index "deals", ["available_on"], name: "index_deals_on_available_on", using: :btree
  add_index "deals", ["ends_on"], name: "index_deals_on_ends_on", using: :btree
  add_index "deals", ["product_id"], name: "index_deals_on_product_id", using: :btree
  add_index "deals", ["slug"], name: "index_deals_on_slug", unique: true, using: :btree

  create_table "deals_products", force: :cascade do |t|
    t.integer "deal_id"
    t.integer "product_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "description", limit: 255
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: :cascade do |t|
    t.string   "description", limit: 255
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "features", ["product_id"], name: "index_features_on_product_id", using: :btree

  create_table "fine_prints", force: :cascade do |t|
    t.text     "description"
    t.boolean  "is_default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "option_values", force: :cascade do |t|
    t.integer  "option_id"
    t.string   "name",       limit: 255
    t.string   "display",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "option_values", ["option_id"], name: "index_option_values_on_option_id", using: :btree

  create_table "option_values_variants", force: :cascade do |t|
    t.integer "option_value_id"
    t.integer "variant_id"
  end

  add_index "option_values_variants", ["option_value_id", "variant_id"], name: "index_option_values_variants_on_option_value_id_and_variant_id", unique: true, using: :btree
  add_index "option_values_variants", ["option_value_id"], name: "index_option_values_variants_on_option_value_id", using: :btree
  add_index "option_values_variants", ["variant_id"], name: "index_option_values_variants_on_variant_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "option_id"
  end

  add_index "options_products", ["product_id", "option_id"], name: "index_options_products_on_product_id_and_option_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "deal_id"
    t.integer  "quantity"
    t.integer  "supplier_id"
    t.integer  "variant_id"
    t.string   "aasm_state",  limit: 255
    t.decimal  "price"
  end

  add_index "order_items", ["deal_id"], name: "index_order_items_on_deal_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["supplier_id"], name: "index_order_items_on_supplier_id", using: :btree
  add_index "order_items", ["variant_id"], name: "index_order_items_on_variant_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "quantity"
    t.string   "special_instructions", limit: 255
    t.string   "coupon_code",          limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state",           limit: 255
    t.decimal  "total"
    t.integer  "user_id"
    t.string   "step_status",          limit: 255
    t.string   "transaction_no",       limit: 255
    t.string   "email",                limit: 255
    t.string   "billing_first_name",   limit: 255
    t.string   "billing_last_name",    limit: 255
    t.string   "billing_address1",     limit: 255
    t.string   "billing_suburb",       limit: 255
    t.string   "billing_state",        limit: 255
    t.integer  "billing_postcode"
    t.string   "shipping_first_name",  limit: 255
    t.string   "shipping_last_name",   limit: 255
    t.string   "shipping_address1",    limit: 255
    t.string   "shipping_suburb",      limit: 255
    t.string   "shipping_state",       limit: 255
    t.integer  "shipping_postcode"
    t.string   "billing_company",      limit: 255
    t.string   "shipping_company",     limit: 255
    t.string   "billing_address2",     limit: 255
    t.string   "billing_mobile",       limit: 255
    t.string   "billing_phone",        limit: 255
    t.string   "shipping_address2",    limit: 255
    t.string   "shipping_mobile",      limit: 255
    t.string   "shipping_phone",       limit: 255
    t.string   "tracking_no",          limit: 255
    t.datetime "purchased_at"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "alt_text",    limit: 255
    t.string   "picture",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "description"
    t.integer  "position"
  end

  add_index "photos", ["product_id"], name: "index_photos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "brand",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.string   "name",             limit: 255
    t.text     "description"
    t.boolean  "status"
    t.string   "meta_description", limit: 255
    t.string   "permalink",        limit: 255
    t.string   "slug",             limit: 255
    t.string   "is_active",        limit: 255
    t.integer  "category_id"
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree

  create_table "referrals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: :cascade do |t|
    t.string   "location",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "phone",      limit: 255
    t.string   "fax",        limit: 255
    t.string   "mobile",     limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abn",        limit: 255
  end

  create_table "user_discounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "discount_id"
    t.boolean  "applied"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_discounts", ["user_id"], name: "index_user_discounts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "shipping_id"
    t.integer  "billing_id"
    t.string   "mobile",                 limit: 255
    t.string   "phone",                  limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "name",                   limit: 255
    t.string   "referral_id",            limit: 255
    t.string   "referred_by",            limit: 255
  end

  add_index "users", ["billing_id"], name: "index_users_on_billing_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["shipping_id"], name: "index_users_on_shipping_id", using: :btree

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id",             null: false
    t.string   "sku",        limit: 255
    t.decimal  "price"
    t.decimal  "cost"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.boolean  "is_master"
    t.decimal  "height"
    t.decimal  "width"
    t.decimal  "depth"
    t.decimal  "weight"
    t.integer  "position"
  end

  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree
  add_index "variants", ["sku"], name: "index_variants_on_sku", using: :btree

  create_table "variants_options", force: :cascade do |t|
    t.integer "variant_id"
    t.integer "option_value_id"
  end

  add_index "variants_options", ["option_value_id"], name: "index_variants_options_on_option_value_id", using: :btree
  add_index "variants_options", ["variant_id"], name: "index_variants_options_on_variant_id", using: :btree

  add_foreign_key "deal_prices", "deals"
  add_foreign_key "deal_prices", "variants"
end
