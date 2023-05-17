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
    expect(page).to have_content "Criando lote para leilão"
    expect(page).to have_content "Produto"
    expect(page).to have_content "Data final do lote"
    expect(page).to have_content "Valor mínimo"
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
    fill_in 'Código do Leilão', with: 'SAM123456'
    fill_in 'Data inicio do lote', with: 4.days.from_now
    fill_in 'Data final do lote', with: 2.months.from_now
    fill_in 'Valor mínimo', with: 1000
    fill_in 'Valor diferença', with: 200
    click_on 'Enviar' 

    #Assert
    expect(page).to have_content "Cadastro do lote de leilão efetuado com sucesso."
    expect(page).to have_content "Código do Leilão: SAM123456"
    expect(page).to have_content "Data de início: #{4.day.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Data final do lote: #{2.months.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Valor mínimo: R$ 1.000,00"
    expect(page).to have_content "Valor diferença: R$ 200,00"
    expect(page).to have_content "Responsável: pedro@leilaodogalpao.com.br"
    expect(page).to have_content "Status: Aguardando aprovação"
  end
  it 'com falha' do
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
    fill_in 'Código do Leilão', with: 'SAMD123456'
    fill_in 'Data final do lote', with: '20/08/2023'
    fill_in 'Valor mínimo', with: 1000
    fill_in 'Valor diferença', with: 200
    click_on 'Enviar' 

    #Assert
    expect(page).to have_content "Falha ao criar o lote de leilão"
    expect(page).to have_content "Código do Leilão Inválido"
  end
  it 'e volta a tela inicial' do
    #Arrange
    admin = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')

    #Act
    login_as(admin)
    visit root_path
    click_on 'Lote de leilão'
    click_on 'Voltar'

    #Assert
    expect(current_path).to eq(root_path)
  end
end