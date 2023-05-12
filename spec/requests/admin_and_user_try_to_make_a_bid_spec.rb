require 'rails_helper'

describe 'Ao tentar realizar o lance' do
  it 'o administrador é barrado' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071', role: "customer")

    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
        registry_code: '52059095018', role: "admin")

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
    status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    post(auction_lot_bids_path(auction_lot), params: { bid: {amount: 1500, user: admin, auction_lot: auction_lot}})
    #Assert
    expect(response).to redirect_to(root_path)
  end
  it 'o usuario deslogado é barrado' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071', role: "customer")

    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

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
                                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    post(auction_lot_bids_path(auction_lot), params: { bid: {amount: 1500, user: '', auction_lot: auction_lot}})
    #Assert
    expect(response).to redirect_to(new_user_session_path)
  end
end