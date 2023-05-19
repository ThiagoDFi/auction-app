require 'rails_helper'

describe 'Admin revisa o lote de leilão' do
  it 'e autorização sua publicação' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
    registry_code: '07699032071', role: "admin")

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
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    find("#auction_lot_1", text: "Ver Detalhes").click
    click_on 'Aprovar'

    #Assert
    expect(page).to have_content "Aprovado por: admin@leilaodogalpao.com.br"
    expect(page).to have_content "Status: Ativo"
    expect(page).not_to have_button "Aprovar"
  end
  it 'falha caso seja o dono do lote' do
    #Arrange
    pedro = User.create!(name: 'pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
    registry_code: '27858256084', role: "admin")

    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
    registry_code: '07699032071', role: "admin")

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
                                     status: :draft)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)

    #Act
    login_as(pedro)
    visit root_path
    click_on 'Lote de leilão'
    find("#auction_lot_1", text: "Ver Detalhes").click
    click_on 'Aprovar'

    #Assert
    expect(page).to have_content "Voce não pode aprovar esse lote"
    expect(page).not_to have_content "Aprovado por: pedro@leilaodogalpao.com.br"
  end
  it 'e visualiza apenas lotes aguardando a aprovação' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '27858256084', role: "admin")

    auction_lot1 = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
    admin_record: 'pedro@leilaodogalpao.com.br',
    status: :draft)

    auction_lot2 = AuctionLot.create!(start_date: 4.days.from_now, end_date: 4.months.from_now,
    minimum_value: 1000, diff_value: 300, code: 'BRA123456',
    admin_record: 'pedro@leilaodogalpao.com.br',
    admin_approve: 'admin@leilaodogalpao.com.br',
    status: :active)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'

    #Assert
    expect(page).to have_content "Código: GRU123456"
    expect(page).to have_content "Inicio: #{auction_lot1.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Final: #{auction_lot1.end_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "BRA123456"
    expect(page).not_to have_content "Inicio: #{auction_lot2.start_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Final: #{auction_lot2.end_date.strftime("%d/%m/%Y")}"
  end
  it 'e falha caso não tenha product_item' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
    registry_code: '27858256084', role: "admin")

    auction_lot1 = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
    admin_record: 'pedro@leilaodogalpao.com.br',
    status: :draft)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    find("#auction_lot_1", text: "Ver Detalhes").click
    click_on 'Aprovar'

    #Assert
    expect(page).to have_content "O lote não pode ser aprovado sem ter ao menos um produto vinculados."
    expect(page).to have_content "Aguardando aprovação"
  end
  it 'ao aprovar não consegue mais remover o product_item' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
    registry_code: '27858256084', role: "admin")

    product1 = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
    weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product1.save!

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br',
                    admin_approve: 'admin@leilaodogalpao.com.br',
                    status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).to have_content "Categoria: Tecnologia"
    expect(page).not_to have_content "Remover"
  end
end
