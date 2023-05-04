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

    auction_lot = AuctionLot.create!(product: product, start_date: Date.today, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br')

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on 'GRU123456'
    click_on 'Editar'
    select 'Playstation 5', from: 'Produto'
    fill_in 'Data final do lote', with: 8.months.from_now
    fill_in 'Valor minimo', with: 4000
    fill_in 'Valor diferença de lance', with: 500
    click_on 'Enviar'

    #Assert
    expect(page).to have_content "Lote de leilão atualizado com sucesso."
    expect(page).to have_content "Código do Leilão: GRU123456"
    expect(page).to have_content "Produto: Playstation 5"
    expect(page).to have_content "Data inicio: #{Date.today}"
    expect(page).to have_content "Data final do lote: #{8.months.from_now.strftime("%d/%m/%Y")}"
    expect(page).to have_content "Valor minimo: 4000"
    expect(page).to have_content "Valor diferença: 500"
    expect(page).to have_content "Responsavel: pedro@leilaodogalpao.com.br"
  end
end