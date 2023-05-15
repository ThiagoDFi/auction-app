require 'rails_helper'

describe 'Usuario busca por um produto' do
  it 'a partir do menu' do
    #Arrange

    #Act
    visit root_path

    #Assert
    within('nav') do
      expect(page).to have_field 'Busque um produto'
      expect(page).to have_button 'Buscar'
    end
  end
  it 'e encontra um lote que contenha o produto' do
    #Arrange
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
    visit root_path
    fill_in 'Busque um produto', with: product1.name
    click_on 'Buscar'

    #Assert
    expect(page).to have_content "Resultado da Busca por: #{product1.name}"
    expect(page).to have_content "1 lote de leilão encontrado"
    expect(page).to have_content "Código do lote: #{auction_lot.code}"
  end
end