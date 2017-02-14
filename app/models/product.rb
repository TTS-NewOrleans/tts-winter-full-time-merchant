class Product < ApplicationRecord
  belongs_to :brand, optional: true
  belongs_to :category, optional: true

  has_attached_file :avatar,
                    styles: { medium: "300x300#",
                              thumb: "100X100#" },
                    default_url: "missing_:style.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
