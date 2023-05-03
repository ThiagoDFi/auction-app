class Product < ApplicationRecord

  validates :name, :description, :weight, :width, :height, :depth,
            :category, :code, :photo, presence: true

  validates :code, uniqueness: true

  has_one_attached :photo

  before_validation :generate_code

  def dimension
    "#{height}cm x #{width}cm x #{depth}cm"
  end

  def generate_code
    self.code = SecureRandom.alphanumeric(10)
  end
end
