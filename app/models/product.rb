class Product < ApplicationRecord

  belongs_to :auction_lot

  validates :name, :description, :weight, :width, :height, :depth,
            :category, :code, :photo, presence: true

  validates :code, uniqueness: true

  has_one_attached :photo

  before_validation :generate_code



  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end
end
