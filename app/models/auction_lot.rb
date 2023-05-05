class AuctionLot < ApplicationRecord
  has_many :products
  
  validates :code, :start_date, :end_date, :minimum_value, :diff_value, :admin_record, presence: true
  validate :code_valid?


  def code_valid?
    unless self.code.present? && self.code.match?(/^(?=.*[A-Za-z]{3})(?=.*\d{6})[A-Za-z\d]{9}$/)
      self.errors.add(:code, "Inválido")
    end
  end
end
