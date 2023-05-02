require 'rails_helper'

describe 'Admin cadastra um producto' do
  it 'a partir da tela inicial' do

    #Arrange

    #Act
    visit root_path
    click_on 'Produtos'
    click_on '+ Novo Produto'
    
    #Assert
    expect(page).to have_content "Criação de Pedido"
    expect(page).to have_content "Nome"
    expect(page).to have_content "Descrição"
    expect(page).to have_content "Foto"
    expect(page).to have_content "Peso"
    expect(page).to have_content "Largura"
    expect(page).to have_content "Altura"
    expect(page).to have_content "Profundidade"
    expect(page).to have_content "Categoria"
  end

  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Produtos'
    click_on '+ Novo Produto'
    fill_in 'Nome', with: 'Iphone 14'
    fill_in 'Descrição', with: 'Celular da Apple de ultima geração'
    attach_file 'Foto do Produto', Rails.root.join('spec', 'support', 'iphone.jpeg')
    fill_in 'Peso', with: '3'
    fill_in 'Largura', with: '1'
    fill_in 'Altura', with: '5'
    fill_in 'Profundidade', with: '1'
    fill_in 'Categoria', with: 'Tecnologia'
    click_on 'Enviar'

    #Assert
    expect(page).to have_content "Produto cadastrado com sucesso."
    expect(page).to have_content "Nome: Iphone 14"
    expect(page).to have_content "Descrição: Celular da Apple de ultima geração"
    expect(page).to have_css('img[src*="iphone.jpeg"]')
    expect(page).to have_content "Peso: 3g"
    expect(page).to have_content "Dimensão: 5cm x 1cm x 1cm"
    expect(page).to have_content "Categoria: Tecnologia" 
  end

  it 'com dados incompletos' do
    #Arrange

    #Act
    visit root_path
    click_on 'Produtos'
    click_on '+ Novo Produto'
    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Categoria', with: ''
    click_on 'Enviar'

    #Assert
    expect(page).to have_content "Produto não cadastado."
    expect(page).to have_content "Nome não pode ficar em branco"
    expect(page).to have_content "Descrição não pode ficar em branco"
    expect(page).to have_content "Foto não pode ficar em branco"
    expect(page).to have_content "Peso não pode ficar em branco"
    expect(page).to have_content "Largura não pode ficar em branco"
    expect(page).to have_content "Altura não pode ficar em branco"
    expect(page).to have_content "Profundidade não pode ficar em branco"
    expect(page).to have_content "Categoria não pode ficar em branco"
  end
end