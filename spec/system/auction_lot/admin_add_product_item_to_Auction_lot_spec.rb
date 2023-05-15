require 'rails_helper'

describe 'Admin adiciona itens a um lote' do
  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')
    
    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                         weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                 admin_record: 'pedro@leilaodogalpao.com.br')
    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code
    click_on 'Adicionar Items'
    select 'Tv 40', from: 'Produtos'
    click_on 'Gravar'

    #Assert
    expect(current_path).to eq auction_lot_path(auction_lot.id)
    expect(page).to have_content 'Item adicionado com sucesso.'
    expect(page).to have_content 'Tv 40'
  end
  it 'adiciona mais de um produto' do
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

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
            minimum_value: 1000, diff_value: 300, code: 'GRU123456',
            admin_record: 'pedro@leilaodogalpao.com.br')
    
    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code

    #Assert
    expect(current_path).to eq auction_lot_path(auction_lot.id)
    expect(page).to have_content 'Tv 40'
    expect(page).to have_content 'Playstation 5'
  end
  it 'e ve somente produtos ativos' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '31350282081', role: 'admin')

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                          weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :active)
    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
                           weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :inactive)                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save! 

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
            minimum_value: 1000, diff_value: 300, code: 'GRU123456',
            admin_record: 'pedro@leilaodogalpao.com.br')
  
    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on auction_lot.code
    click_on 'Adicionar Items'

    #Assert
    expect(page).to have_content 'Tv 40'
    expect(page).not_to have_content 'Playstation 5'
  end
  it 'falha caso status seja ativo' do
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

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br',
                                     admin_approve: 'admin@leilaodogalpao.com.br',
                                     status: :active)
    
    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).not_to have_link "Adicionar Items"
  end
end