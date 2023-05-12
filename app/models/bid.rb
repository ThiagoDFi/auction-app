class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction_lot

  validates :amount, presence: true
  validate :check_minimum
  validate :check_diff, if: :has_previous_bid?
  validate :check_valid_date_for_bid

  def check_minimum
    if self.amount.present? && self.amount <= auction_lot.minimum_value
      self.errors.add(:amount, "deve ser maior que o valor minimo")
    end
  end

  def check_diff
    if auction_lot.bids.count == 1
      last_bid = auction_lot.bids.first
      if last_bid.present? && (self.amount - last_bid.amount) < auction_lot.diff_value
        self.errors.add(:amount, "deve respeitar o valor de diferença configurado")
      end
    else
      last_bid = auction_lot.bids.offset(1).last
      if last_bid.present? && (self.amount - last_bid.amount) < auction_lot.diff_value
        self.errors.add(:amount, "deve respeitar o valor de diferença configurado")
      end
    end
  end

  def has_previous_bid?
    auction_lot.bids.count >= 1
  end

  def check_valid_date_for_bid
    if Date.today < auction_lot.start_date || Date.today > auction_lot.end_date
      self.errors.add(:amount, "não pode ser registrado fora do periodo do lote")
    end
  end
end
