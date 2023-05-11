require 'rails_helper'

describe 'Usuário visita a inical' do
  it 'e ve o nome do app' do

    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to have_content "Leilão"
  end
  it 'e ve os lotes ativos' do
    #Arrange
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

    #Act
    visit root_path


    #Assert
    expect(page).to have_content "Código: GRU123456"
    expect(page).to have_content "Tecnologia"
    expect(page).to have_content "Inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_link "Ver Detalhes"
  end
end
