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

ActiveRecord::Schema.define(version: 20170611173225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "suburb"
    t.string   "state"
    t.integer  "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "mobile"
    t.string   "phone"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.integer  "roles_mask"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["username"], name: "index_admins_on_username", unique: true, using: :btree

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "user_id"
    t.boolean  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.integer  "deal_id"
    t.integer  "variant_id"
    t.integer  "frequency"
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
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "coupon_codes", force: :cascade do |t|
    t.integer  "coupon_id"
    t.integer  "order_id"
    t.string   "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "coupon_codes", ["code"], name: "index_coupon_codes_on_code", unique: true, using: :btree

  create_table "coupons", force: :cascade do |t|
    t.string   "title"
    t.string   "code"
    t.string   "description"
    t.decimal  "amount"
    t.decimal  "percent"
    t.date     "starts_at"
    t.decimal  "expires_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "coupons", ["code"], name: "index_coupons_on_code", unique: true, using: :btree

  create_table "credits", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "reason"
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
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "available_on"
    t.datetime "ends_on"
    t.boolean  "is_active",      default: false
    t.integer  "max_quantity"
    t.string   "slug"
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
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discounts", force: :cascade do |t|
    t.string   "description"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", force: :cascade do |t|
    t.string   "description"
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
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "option_values", force: :cascade do |t|
    t.integer  "option_id"
    t.string   "name"
    t.string   "display"
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
    t.string   "name"
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
    t.string   "aasm_state"
    t.decimal  "price"
  end

  add_index "order_items", ["deal_id"], name: "index_order_items_on_deal_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["supplier_id"], name: "index_order_items_on_supplier_id", using: :btree
  add_index "order_items", ["variant_id"], name: "index_order_items_on_variant_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "quantity"
    t.string   "special_instructions"
    t.string   "coupon_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aasm_state"
    t.decimal  "total"
    t.integer  "user_id"
    t.string   "step_status"
    t.string   "transaction_no"
    t.string   "email"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_address1"
    t.string   "billing_suburb"
    t.string   "billing_state"
    t.integer  "billing_postcode"
    t.string   "shipping_first_name"
    t.string   "shipping_last_name"
    t.string   "shipping_address1"
    t.string   "shipping_suburb"
    t.string   "shipping_state"
    t.integer  "shipping_postcode"
    t.string   "billing_company"
    t.string   "shipping_company"
    t.string   "billing_address2"
    t.string   "billing_mobile"
    t.string   "billing_phone"
    t.string   "shipping_address2"
    t.string   "shipping_mobile"
    t.string   "shipping_phone"
    t.string   "tracking_no"
    t.datetime "purchased_at"
    t.decimal  "postage",              default: 0.0
    t.integer  "coupon_code_id"
    t.integer  "subscription_id"
    t.string   "courier"
  end

  add_index "orders", ["coupon_code_id"], name: "index_orders_on_coupon_code_id", using: :btree
  add_index "orders", ["subscription_id"], name: "index_orders_on_subscription_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payment_methods", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "braintree_token"
    t.boolean  "default",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "payment_methods", ["user_id"], name: "index_payment_methods_on_user_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "alt_text"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.string   "description"
    t.integer  "position"
  end

  add_index "photos", ["product_id"], name: "index_photos_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "status"
    t.string   "meta_description"
    t.string   "permalink"
    t.string   "slug"
    t.integer  "category_id"
    t.boolean  "is_active",          default: true
    t.integer  "brand_id"
    t.boolean  "repeat_deliverable", default: true
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id", using: :btree
  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["supplier_id"], name: "index_products_on_supplier_id", using: :btree

  create_table "referrals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: :cascade do |t|
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "variant_id"
    t.integer  "payment_method_id"
    t.integer  "frequency"
    t.integer  "quantity"
    t.decimal  "postage",             precision: 10, scale: 2
    t.datetime "start_at"
    t.datetime "end_at"
    t.date     "last_order_on"
    t.date     "next_order_on"
    t.string   "aasm_state"
    t.string   "email"
    t.string   "billing_first_name"
    t.string   "billing_last_name"
    t.string   "billing_address1"
    t.string   "billing_suburb"
    t.string   "billing_state"
    t.integer  "billing_postcode"
    t.string   "shipping_first_name"
    t.string   "shipping_last_name"
    t.string   "shipping_address1"
    t.string   "shipping_suburb"
    t.string   "shipping_state"
    t.integer  "shipping_postcode"
    t.string   "billing_company"
    t.string   "shipping_company"
    t.string   "billing_address2"
    t.string   "billing_mobile"
    t.string   "billing_phone"
    t.string   "shipping_address2"
    t.string   "shipping_mobile"
    t.string   "shipping_phone"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "subscriptions", ["payment_method_id"], name: "index_subscriptions_on_payment_method_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  add_index "subscriptions", ["variant_id"], name: "index_subscriptions_on_variant_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abn"
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
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "shipping_id"
    t.integer  "billing_id"
    t.string   "mobile"
    t.string   "phone"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "referral_id"
    t.string   "referred_by"
    t.string   "braintree_customer_id"
  end

  add_index "users", ["billing_id"], name: "index_users_on_billing_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["shipping_id"], name: "index_users_on_shipping_id", using: :btree

  create_table "variants", force: :cascade do |t|
    t.integer  "product_id",                       null: false
    t.string   "sku"
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
    t.decimal  "original_price"
    t.integer  "percentage_saved"
    t.boolean  "free_postage",     default: false
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
  add_foreign_key "orders", "coupon_codes"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "subscriptions", "payment_methods"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "subscriptions", "variants"
end
