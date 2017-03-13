class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user, optional: true

  PAYMENT_TYPES = ['Check', 'Credit Card', 'PayPal', 'Wampum', 'Smiles', 'C.O.D.']
  validates :pay_type, inclusion: PAYMENT_TYPES

  # Pull items out of the cart and add them to the order
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      # Remove the cart id
      item.cart_id = nil
      # Add to order line items
      line_items << item
    end
  end

  def subtotal
    line_items.select("SUM(quantity * price) AS sum")[0].sum
  end
end
