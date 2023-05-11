require 'rails_helper'

describe 'Usuario ve os detalhes de um lot' do
  it 'com sucesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
           weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
           weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :inactive)                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save! 

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br')

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).to have_content "Data inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Data final do lote: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor mínimo: R$ 1.000,00"
    expect(page).to have_content "Valor diferença: R$ 300,00"
    expect(page).to have_content "Tv 40"
    expect(page).to have_content "Tv de ultima geração LED 4K"
    expect(page).to have_content "Dimensões: 60cm x 10cm x 10cm"
    expect(page).to have_content "Peso: 70g"
    expect(page).to have_content "Categoria: Tecnologia"
  end
  it 'de um lote ativo' do
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

    pedro = User.create!(name: 'pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '27858256084', role: "admin")

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

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).to have_content "Data inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Data final do lote: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor mínimo: R$ 1.000,00"
    expect(page).to have_content "Valor diferença: R$ 300,00"
    expect(page).to have_content "Tv 40"
    expect(page).to have_content "Tv de ultima geração LED 4K"
    expect(page).to have_content "Dimensões: 60cm x 10cm x 10cm"
    expect(page).to have_content "Peso: 70g"
    expect(page).to have_content "Categoria: Tecnologia"
    expect(page).not_to have_button "Aprovar"
  end
  it 'de um lote aguardando aprovação' do
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

    pedro = User.create!(name: 'pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '27858256084', role: "admin")

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

    auction_lot = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :draft)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).to have_content "Data inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Data final do lote: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor mínimo: R$ 1.000,00"
    expect(page).to have_content "Valor diferença: R$ 300,00"
    expect(page).to have_content "Tv 40"
    expect(page).to have_content "Tv de ultima geração LED 4K"
    expect(page).to have_content "Dimensões: 60cm x 10cm x 10cm"
    expect(page).to have_content "Peso: 70g"
    expect(page).to have_content "Categoria: Tecnologia"
    expect(page).not_to have_button "Aprovar"
    expect(page).not_to have_content "Valor do lance"
    expect(page).not_to have_content "Enviar lance"
    expect(page).to have_content "Status: Aguardando aprovação"
  end
end