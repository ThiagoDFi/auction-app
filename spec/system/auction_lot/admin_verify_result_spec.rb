require 'rails_helper'

describe 'admin verifica resultados' do 
  it 'a partir da tela inicial' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    #Act
    login_as(admin)
    visit root_path
    within('nav') do
      click_on 'Resultados'
    end

    #Assert
    expect(page).to have_content 'Validação de resultados dos leilões'
  end
  it 'e ve os leilões que podem ser encerrado ou cancelados' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

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

    auction_lot = AuctionLot.create!(start_date: 2.days.ago, end_date: 2.days.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    bid1 = Bid.create!(amount: 1500, auction_lot: auction_lot, user: user)
    
    auction_lot.update(start_date: 2.months.ago, end_date: 2.days.ago)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'

    #Assert
    expect(page).to have_content "GRU123456"
    expect(page).to have_content "Encerrado em: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor inicial: R$ 1.000,00"
    expect(page).to have_content "Ultimo lance: R$ 1.500,00"
    expect(page).to have_content "Ganhador: #{user.name}"
    expect(page).to have_button "Finalizar"
  end
  it 'e finaliza um leilão' do 
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

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

    auction_lot = AuctionLot.create!(start_date: 2.days.ago, end_date: 2.days.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    bid1 = Bid.create!(amount: 1500, auction_lot: auction_lot, user: user)
    
    auction_lot.update(start_date: 2.months.ago, end_date: 2.days.ago)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'
    find("#auction_lot_1", text: "Finalizar").click

    #Assert
    expect(page).to have_content "Lote de leilão finalizado com sucesso!"
    expect(page).not_to have_content "Código: GRU123456"
    expect(page).not_to have_content "Encerrado em: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Valor inicial: R$ 1.000,00"
    expect(page).not_to have_content "Ultimo lance: R$ 1.500,00"
    expect(page).not_to have_content "Ganhador: #{user.name}"
  end
  it 'e cancela caso não tenha nenhum lance' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071')

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

    auction_lot = AuctionLot.create!(start_date: 4.days.ago, end_date: 2.days.ago,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br',
                                     admin_approve: 'admin@leilaodogalpao.com.br',
                                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'
    find("#auction_lot_1", text: "Cancelar").click

    #Assert
    expect(page).to have_content "Lote de leilão cancelado com sucesso!"
    expect(page).not_to have_content "Código: GRU123456"
    expect(page).not_to have_content "Encerrado em: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Valor inicial: R$ 1.000,00"
    expect(page).not_to have_content "Ultimo lance: R$ 1.500,00"
    expect(page).not_to have_content "Ganhador: #{user.name}"
  end
  it 'visualiza cancelar apenas se não tiver lance' do
    #Arrange
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

    auction_lot = AuctionLot.create!(start_date: 4.days.ago, end_date: 2.days.ago,
                         minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                         admin_record: 'pedro@leilaodogalpao.com.br',
                         admin_approve: 'admin@leilaodogalpao.com.br',
                         status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'

    #Assert
    expect(page).not_to have_button "Finalizar"
    expect(page).to have_button 'Cancelar'
  end
  it 'visualiza finalizar apenas se tiver algum lance' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
    registry_code: '07699032071')

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

    auction_lot = AuctionLot.create!(start_date: 2.days.ago, end_date: 2.days.from_now,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    bid1 = Bid.create!(amount: 1500, auction_lot: auction_lot, user: user)
    
    auction_lot.update(start_date: 2.months.ago, end_date: 2.days.ago)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'

    #Assert
    expect(page).to have_button "Finalizar"
    expect(page).not_to have_button 'Cancelar'
  end
  it 'cancela o lote e os produtos do lote são ativos automaticamente' do
    #Arrange
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

    auction_lot = AuctionLot.create!(start_date: 4.days.ago, end_date: 2.days.ago,
                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                     admin_record: 'pedro@leilaodogalpao.com.br',
                     admin_approve: 'admin@leilaodogalpao.com.br',
                     status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'
    find("#auction_lot_1", text: "Cancelar").click
    product = Product.find(auction_lot.product_items.first.product_id)
    result = product.status

    #Assert
    expect(result).to eq("active")
  end
  it 'e volta a pagina inicial' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    #Act
    login_as(admin)
    visit root_path
    click_on 'Resultados'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq(root_path)
  end
end
