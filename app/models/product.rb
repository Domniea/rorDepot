class Product < ApplicationRecord


  validates :title, :description, :image_url, presence: true;
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: 'Must be a URL for GIF, JPG, or PNG locations.'
  }
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
end
