require 'rails_helper'

describe 'usuario acessa seus favoritos e remove um lote' do
  it 'com sucesso' do
    #Arrange
    thiago = User.create!(name: 'Thiago', email: 'thaigoteste@gmail.com', password: 'password',
                          registry_code: '31340396050', role: "customer")

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

    fav = Favorite.create!(user: thiago, auction_lot: auction_lot)

    #Act
    login_as(thiago)
    visit root_path
    click_on 'Favoritos'
    click_on 'Remover'

    #Assert
    expect(page).to have_content 'O lote foi removido dos favoritos.'
    expect(page).not_to have_content "Código: GRU123456"
    expect(page).not_to have_content "Inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Final: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
  end
  it 'e não remove outros lotes' do
    #Arrange
    thiago = User.create!(name: 'Thiago', email: 'thaigoteste@gmail.com', password: 'password',
    registry_code: '31340396050', role: "customer")

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
         weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
         weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :inactive)                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save! 

    auction_lot1 = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                   minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                   admin_record: 'pedro@leilaodogalpao.com.br',
                   admin_approve: 'admin@leilaodogalpao.com.br',
                   status: :active)

    auction_lot2 = AuctionLot.create!(start_date: 2.days.from_now, end_date: 1.months.from_now,
                   minimum_value: 2000, diff_value: 200, code: 'BRA987456',
                   admin_record: 'pedro@leilaodogalpao.com.br',
                   admin_approve: 'admin@leilaodogalpao.com.br',
                   status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot1)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot2)

    fav1 = Favorite.create!(user: thiago, auction_lot: auction_lot1)
    fav2 = Favorite.create!(user: thiago, auction_lot: auction_lot2)

    #Act
    login_as(thiago)
    visit root_path
    click_on "Favoritos"
    click_button 'Remover', id: 'favorite_1'
    

    #Assert
    expect(page).to have_content 'O lote foi removido dos favoritos.'
    expect(page).to have_content "Código: BRA987456"
    expect(page).to have_content "Início: #{auction_lot2.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Final: #{auction_lot2.end_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Código: GRU123456"
    expect(page).not_to have_content "Início:: #{auction_lot1.start_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Final: #{auction_lot1.end_date.strftime("%d/%m/%Y")}"
  end
end