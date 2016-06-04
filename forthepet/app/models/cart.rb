class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_items, -> { includes(:variant).where('cart_items.is_active = ?', true).order(created_at: :desc) }

  default_scope { includes(:cart_items) }

  def add_item(cart_item)
    cart_item.is_active = true

    cart_items.each do |c|
      if c.variant_id == cart_item.variant_id
        c.quantity += cart_item.quantity
        c.save && return
      end
    end

    cart_items << cart_item
  end

  def total
    @total ||= cart_items.inject(0) { |total, cart_item| total += cart_item.total }
  end

  def cart_quantity
    @cart_quantity ||= cart_items.inject(0) { |total, cart_item| total += cart_item.quantity }
  end

  def print_quantity
    empty? ? '' : cart_quantity
  end

  def empty?
    cart_quantity == 0
  end
end
