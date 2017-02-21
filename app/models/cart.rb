class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # Increment quantity if product is already in cart
  # Add new line item if product isn't in cart
  def add_product(product_id)
    product = Product.find(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, price: product.price)
    end

    current_item
  end

  def subtotal
    # SQL version, much faster than Ruby
    line_items.select("SUM(quantity * price) AS sum")[0].sum
     # Ruby version
     # line_items.to_a.sum { |item| item.total }
  end
end
