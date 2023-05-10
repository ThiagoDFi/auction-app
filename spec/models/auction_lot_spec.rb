require 'rails_helper'

RSpec.describe AuctionLot, type: :model do
  describe '#valid?' do
    it 'codigo deve ser unico' do
      #Arrange
      auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                       minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                       admin_record: 'pedro@leilaodogalpao.com.br')
      
      lot = AuctionLot.new(code: 'GRU123456')

      #Act
      lot.valid?
      result = lot.errors.include?(:code)

      #Assert
      expect(result).to be true
    end
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
    it 'data inicial deve dar erro se nor nula' do
      #Arrange
      lot = AuctionLot.new(start_date: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:start_date)

      #Assert
      expect(result).to be true
    end
    it 'data final do lote deve dar erro se nor nula' do
      #Arrange
      lot = AuctionLot.new(end_date: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:end_date)

      #Assert
      expect(result).to be true
    end
    it 'Valor minimo deve dar erro se nor nula' do
      #Arrange
      lot = AuctionLot.new(minimum_value: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:minimum_value)

      #Assert
      expect(result).to be true
    end
    it 'Valor de diferença deve dar erro se nor nula' do
      #Arrange
      lot = AuctionLot.new(diff_value: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:diff_value)

      #Assert
      expect(result).to be true
    end
    it 'Responsavel deve dar erro se nor nula' do
      #Arrange
      lot = AuctionLot.new(admin_record: '')

      #Act
      lot.valid?
      result = lot.errors.include?(:admin_record)

      #Assert
      expect(result).to be true
    end
  end
end
