class AuctionLot < ApplicationRecord
  belongs_to :product

  validates :code, presence: true
  validate :code_valid?

  def code_valid?
    unless self.code.match?(/^(?=.*[A-Za-z]{3})(?=.*\d{6})[A-Za-z\d]{9}$/)
      self.errors.add(:code, "Inválido")
    end
  end
end
