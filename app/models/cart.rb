class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def subtotal
    # SQL version, much faster than Ruby
    line_items.select("SUM(quantity * price) AS sum")[0].sum
     # Ruby version
     # line_items.to_a.sum { |item| item.total }
  end
end
