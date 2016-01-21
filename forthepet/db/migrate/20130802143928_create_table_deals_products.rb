class CreateTableDealsProducts < ActiveRecord::Migration
  def change
    create_table 'addresses', force: true do |t|
      t.string 'unit_no'
      t.string 'street_no'
      t.string 'street_name'
      t.string 'suburb'
      t.string 'state'
      t.integer 'postcode'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string 'street_type'
    end

    create_table 'categories', force: true do |t|
      t.string 'name'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string 'ancestry'
    end

    add_index 'categories', ['ancestry'], name: 'index_categories_on_ancestry'

    create_table 'deals', force: true do |t|
      t.string 'name'
      t.string 'description'
      t.datetime 'start'
      t.datetime 'end'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'deals_products', force: true do |t|
      t.integer 'deal_id'
      t.integer 'product_id'
    end

    create_table 'orders', force: true do |t|
      t.decimal 'total_amount'
      t.integer 'quantity'
      t.string 'special_instructions'
      t.string 'coupon_code'
      t.boolean 'use_billing'
      t.datetime 'created_at'
      t.datetime 'updated_at'
    end

    create_table 'photos', force: true do |t|
      t.string 'alt_text'
      t.string 'picture'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.integer 'product_id'
    end

    create_table 'products', force: true do |t|
      t.string 'name'
      t.string 'brand'
      t.string 'description'
      t.decimal 'price'
      t.decimal 'original_price'
      t.decimal 'discounted_price'
      t.integer 'stock_count'
      t.boolean 'isactive'
      t.string 'meta_description'
      t.datetime 'available_on'
      t.datetime 'finishes_on'
      t.decimal 'weight'
      t.decimal 'height'
      t.decimal 'width'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string 'permalink'
      t.string 'meta_keywords'
      t.decimal 'depth'
      t.integer 'supplier_id'
      t.string 'product_code'
      t.string 'slug'
    end

    add_index 'products', ['slug'], name: 'index_products_on_slug', unique: true

    create_table 'suppliers', force: true do |t|
      t.string 'name'
      t.string 'phone'
      t.string 'fax'
      t.string 'mobile'
      t.string 'email'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string 'abn'
    end

    create_table 'users', force: true do |t|
      t.string 'email',                  default: '', null: false
      t.string 'encrypted_password',     default: '', null: false
      t.string 'reset_password_token'
      t.datetime 'reset_password_sent_at'
      t.datetime 'remember_created_at'
      t.integer 'sign_in_count',          default: 0
      t.datetime 'current_sign_in_at'
      t.datetime 'last_sign_in_at'
      t.string 'current_sign_in_ip'
      t.string 'last_sign_in_ip'
      t.string 'confirmation_token'
      t.datetime 'confirmed_at'
      t.datetime 'confirmation_sent_at'
      t.string 'unconfirmed_email'
      t.datetime 'created_at'
      t.datetime 'updated_at'
      t.string 'first_name'
      t.string 'last_name'
      t.integer 'address_id'
      t.integer 'billing_id'
      t.string 'mobile'
      t.string 'phone'
    end

    add_index 'users', ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    add_index 'users', ['email'], name: 'index_users_on_email', unique: true
    add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
