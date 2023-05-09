require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe '#valid?' do
    it 'adiciona errors quando amount está vazio' do
      #Arrange
      admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '31350282081', role: 'admin')

      product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
             weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
      product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
      product1.save!

      auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                        minimum_value: 100, diff_value: 2, code: 'GRU123456',
                        admin_record: 'pedro@leilaodogalpao.com.br')

      prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)

      bid = Bid.new(amount: '', auction_lot: auction_lot, user: admin)

      #Act
      bid.valid?
      result = bid.errors.include?(:amount)

      #Assert
      expect(result).to be true
    end
  end
  describe 'valor de lance' do
    it 'não deve ser menor que valor minimo' do

      #Arrange
      admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '31350282081', role: 'admin')

      product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
             weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
      product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
      product1.save!

      auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                        minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                        admin_record: 'pedro@leilaodogalpao.com.br')

      prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)

      bid = Bid.new(amount: 900, auction_lot: auction_lot, user: admin)

      #Act
      bid.valid?
      result = bid.errors.include?(:amount)

      #Assert
      expect(bid.errors[:amount]).to include("deve ser maior que o valor minimo")
    end
    it 'deve respeitar a configuração de diferença' do
      #Arrange
      admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '31350282081', role: 'admin')

      product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
             weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
      product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
      product1.save!

      auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                        minimum_value: 100, diff_value: 2, code: 'GRU123456',
                        admin_record: 'pedro@leilaodogalpao.com.br')

      prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)

      bid1 = Bid.create!(amount: 101, auction_lot: auction_lot, user: admin)

      bid = Bid.new(amount: 102, auction_lot: auction_lot, user: admin)
      #Act
      bid.valid?
      result = bid.errors.include?(:amount)

      #Assert
      expect(bid.errors[:amount]).to include("Deve respeitar o valor de diferença configurado")
    end
  end
end
