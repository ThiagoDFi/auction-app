require 'rails_helper'

describe 'Usuario visualiza a tela de resultados' do
  it 'a partir da tela inicial' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071')
    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Resultados'
    end

    #Assert
    expect(page).to have_content "Lotes que voce ganhou!"
  end
  it 'e ve os lotes que ganhou' do
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
    
    auction_lot.update(start_date: 2.months.ago, end_date: 2.days.ago, status: :closed)

    #Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Resultados'
    end

    #Assert
    expect(page).to have_content 'Código do lote: GRU123456'
    expect(page).to have_content "Encerrado em: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content 'Valor do lance: R$ 1.500,00'
    expect(page).to have_content 'Status: Encerrado'
  end
  it 'não autenticado deve ser redirecionado' do
    #Arrange

    #Act
    visit root_path
    within('nav') do
      click_on 'Resultados'
    end

    #Assert
    expect(current_path).to eq(new_user_session_path)
  end
end