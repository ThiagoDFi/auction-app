require 'rails_helper'

describe 'usuario pode adicionar lotes favoritos' do
  it 'e visualiza pagina de favoritos a partir da inicial' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071', role: "customer")

    #Act
    login_as(user)
    visit root_path
    click_on 'Favoritos'

    #Assert
    expect(page).to have_content "Seus lotes favoritos"
  end
  it 'e adiciona um lote aos favoritos' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071', role: "customer")
    
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
    click_on 'Favoritar'

    #Assert
    expect(page).to have_content "Seus lotes favoritos"
    expect(page).to have_content "Código: GRU123456"
    expect(page).to have_content "Início: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Final: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
  end
  it 'e não aparece para outros usuarios' do
    #Arrange
    maria = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071', role: "customer")
    
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
    login_as(maria)
    visit root_path
    click_on 'Favoritos'

    #Assert
    expect(page).to have_content "Você ainda não adicionou nenhum lote aos seus favoritos."
    expect(page).not_to have_content "Código: GRU123456"
    expect(page).not_to have_content "Inicio: #{auction_lot.start_date.strftime("%d/%m/%Y")}"
    expect(page).not_to have_content "Final: #{auction_lot.end_date.strftime("%d/%m/%Y")}"
  end
end