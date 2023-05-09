class Product < ApplicationRecord

  has_many :product_items
  has_many :auction_lots, through: :product_items

  enum status: { active: 0, inactive: 1}

  validates :name, :description, :weight, :width, :height, :depth,
            :category, :code, :photo, presence: true

  validates :code, uniqueness: true

  has_one_attached :photo

  before_validation :generate_code



  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end
end
