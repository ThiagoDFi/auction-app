require 'rails_helper'

RSpec.describe ProductItem, type: :model do
  describe '#valid?' do
    it 'não pode deixar o product_id em branco' do
      #Arrange
      proditem = ProductItem.new(product_id: '')

      #Act
      proditem.valid?
      result = proditem.errors.include?(:product_id)

      #Assert
      expect(result).to be true
    end
    it 'não pode deixar o auction_lot_id em branco' do
      #Arrange
      proditem = ProductItem.new(auction_lot_id: '')

      #Act
      proditem.valid?
      result = proditem.errors.include?(:auction_lot_id)

      #Assert
      expect(result).to be true
    end
  end
end
