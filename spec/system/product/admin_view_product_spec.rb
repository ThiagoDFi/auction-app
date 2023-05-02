require 'rails_helper'

describe 'Admin acessa produtos' do
  it 'e tem produtos cadastrados' do

    #Arrange
    product = Product.create!(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                              weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
    

    #Act
    visit root_path
    click_on 'Produtos'

    #Assert
    expect(page).to have_content "Tv 40"
  end

  it 'e não tem produtos cadastrados' do
    #Arrange

    #Act
    visit root_path
    click_on 'Produtos'

    #Assert
    expect(page).to have_content "Não existem produtos cadastrados."
  end
end