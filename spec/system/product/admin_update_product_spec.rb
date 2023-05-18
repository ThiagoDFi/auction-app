require 'rails_helper'

describe 'Admin edita um produto' do
  it 'a partir dos detalhes de um produto' do

    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                           weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')
    #Act
    login_as(admin)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Editar'
    fill_in 'Nome', with: 'Skate'
    fill_in 'Descrição', with: 'Skate montado completo'
    attach_file 'Foto do Produto', Rails.root.join('spec', 'support', 'skate.jpeg')
    fill_in 'Peso', with: '800'
    fill_in 'Largura', with: '10'
    fill_in 'Altura', with: '7'
    fill_in 'Profundidade', with: '60'
    fill_in 'Categoria', with: 'Lazer'
    click_on 'Enviar'


    #Assert
    expect(page).to have_content "Produto atualizado com sucesso."
    expect(page).to have_content "Nome: Skate"
    expect(page).to have_content "SKU: ABC1234567"
    expect(page).to have_content "Descrição: Skate montado completo"
    expect(page).to have_css('img[src*="skate.jpeg"]')
    expect(page).to have_content "Peso: 800g"
    expect(page).to have_content "Dimensão: 7cm x 10cm x 60cm"
    expect(page).to have_content "Categoria: Lazer" 
  end
  it 'e falha caso não envie nada' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                          weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC1234567')

    #Act
    login_as(admin)
    visit root_path
    click_on 'Produtos'
    click_on product.name
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'Categoria', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content "Falha ao atualizar o produto."
  end
end
