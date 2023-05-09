require 'rails_helper'

describe 'Admin remove um product item' do
  it 'com sucesso' do

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

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code
    click_on "Remover #{product1.name}"

    #Assert
    expect(page).to have_content 'Item removido com sucesso'
    expect(page).not_to have_content 'Tv 40'

  end
  it 'e não apaga outros produtos' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '31350282081', role: 'admin')

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
         weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
          weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia')                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save! 

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br')

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)
    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code
    click_on "Remover #{product1.name}"

    #Assert
    expect(page).to have_content 'Item removido com sucesso'
    expect(page).to have_content 'Playstation 5'
    expect(page).not_to have_content 'Tv 40'
  end
  it 'e ativa o produto novamente' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '31350282081', role: 'admin')

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
                    admin_record: 'pedro@leilaodogalpao.com.br')

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code
    click_on "Remover #{product1.name}"
    product1.reload

    #Assert
    expect(product1.status).to eq "active"
  end
end