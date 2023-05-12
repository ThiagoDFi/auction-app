require 'rails_helper'

describe 'Usuario tenta editar aucion lot' do
  it 'mas não tem acesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071', role: 'customer')

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
    weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
          weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :inactive)                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save! 

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br',
                    admin_approve: 'admin@leilaodogalpao.com.br',
                    status: :draft)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(user)
    patch(auction_lot_path(auction_lot.id), params: {auction_lot: { minimum_value: 500}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end