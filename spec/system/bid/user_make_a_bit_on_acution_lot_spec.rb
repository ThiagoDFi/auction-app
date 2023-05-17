require 'rails_helper'

describe 'Usuario faz um lance' do
  it 'a partir da tela inicial' do
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

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br',
                    admin_approve: 'admin@leilaodogalpao.com.br',
                    status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    
    #Act
    login_as(user)
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).to have_content "Valor do lance"
  end
  it 'com sucesso' do
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

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br',
                    admin_approve: 'admin@leilaodogalpao.com.br',
                    status: :active)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(user)
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click
    fill_in 'Valor do lance', with: 1500
    click_on 'Enviar lance'

    #Assert
    expect(page).to have_content "Lance enviado com sucesso!"
    expect(page).to have_content "Último lance: R$ 1.500,00"
  end
  it 'e informa um valor não permitido' do
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
      
    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br',
                                     admin_approve: 'admin@leilaodogalpao.com.br',
                                     status: :active)
      
    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    bid1 = Bid.create!(amount: 1001, auction_lot: auction_lot, user: user)

    #Act
    login_as(user)
    visit root_path
    first('.btn-primary').click
    fill_in 'Valor do lance', with: 1100
    click_on 'Enviar lance'

    #Assert
    expect(page).to have_content "Valor do lance deve respeitar o valor de diferença configurado"
    expect(page).not_to have_content "Lance enviado com sucesso!"
  end
end