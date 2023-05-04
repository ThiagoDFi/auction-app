require 'rails_helper'

describe 'Administrador cadastra lote de leião' do
  it 'a partir da tela inicial' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on '+ Novo Lote de Leilão'

    #Assert
    expect(page).to have_content "Criando de lote para leilão"
    expect(page).to have_content "Produto"
    expect(page).to have_content "Data final do lote"
    expect(page).to have_content "Valor minimo"
    expect(page).to have_content "Valor diferença de lance"
  end
  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')
    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                         weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on '+ Novo Lote de Leilão'
    select 'Tv 40', from: 'Produto'
    fill_in 'Código do Leilão', with: 'SAM123456'
    fill_in 'Data final do lote', with: '20/08/2023'
    fill_in 'Valor minimo', with: 1000
    fill_in 'Valor diferença', with: 200
    click_on 'Enviar' 

    #Assert
    expect(page).to have_content "Cadastro do lote de leilão efetuado com sucesso."
    expect(page).to have_content "Código do Leilão: SAM123456"
    expect(page).to have_content "Produto: Tv 40"
    expect(page).to have_content "Data inicio: #{Date.today}"
    expect(page).to have_content "Data final do lote: 20/08/2023"
    expect(page).to have_content "Valor minimo: 1000"
    expect(page).to have_content "Valor diferença: 200"
    expect(page).to have_content "Responsavel: pedro@leilaodogalpao.com.br"
  end
end