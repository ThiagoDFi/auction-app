require 'rails_helper'

describe 'Admin edita um lote de leilão' do
  it 'a partir dos detalhes de um lote' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')
    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                         weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!
    
    product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
                          weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia')                     
    product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product2.save!  

    auction_lot = AuctionLot.new(start_date: Date.today, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br')
    auction_lot.products << product2
    auction_lot.save!

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on 'GRU123456'
    click_on 'Editar'
    fill_in 'Data final do lote', with: 8.months.from_now
    fill_in 'Valor minimo', with: 4000
    fill_in 'Valor diferença de lance', with: 500
    click_on 'Enviar'

    #Assert
    expect(page).to have_content "Lote de leilão atualizado com sucesso."
    expect(page).to have_content "Código do Leilão: GRU123456"
    expect(page).to have_content "Data inicio: #{Date.today.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Data final do lote: #{8.months.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor mínimo: R$ 4.000,00"
    expect(page).to have_content "Valor diferença: R$ 500,00"
    expect(page).to have_content "Responsável: pedro@leilaodogalpao.com.br"
  end
  it 'e um usuario comum não ve opção de editar' do 
    #Arrande
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

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                    minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                    admin_record: 'pedro@leilaodogalpao.com.br',
                    admin_approve: 'admin@leilaodogalpao.com.br',
                    status: :draft)

    prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)
    prod2 = ProductItem.create!(product: product2, auction_lot: auction_lot)

    #Act
    login_as(user)
    visit root_path
    find("#auction_lot_1", text: "Ver Detalhes").click

    #Assert
    expect(page).not_to have_link "Editar"
  end 
end