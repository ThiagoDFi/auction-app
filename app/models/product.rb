class Product < ApplicationRecord

  validates :name, :description, :photo, :weight, :width, :height, :depth,
            :category, presence: true

  has_one_attached :photo

  def dimension
    "#{height}cm x #{width}cm x #{depth}cm"
  end
end
