require 'rails_helper'

RSpec.describe AuctionLot, type: :model do
  describe '#valid?' do
    it 'codigo não pode ser vazio' do
      #Arrange
      lot = AuctionLot.new(code: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:code)

      #Assert
      expect(result).to be true
    end
    it 'codigo fora do padrão da erro' do
      #Arrange
      lot = AuctionLot.new(code: 'SAM12345')
      #Act
      lot.valid?
      result = lot.errors.include?(:code)

      #Assert
      expect(result).to be true
    end
  end
end
