require 'rails_helper'

describe 'Usuário visita a inical' do
  it 'e ve o nome do app' do

    #Arrange

    #Act
    visit root_path

    #Assert
    expect(page).to have_content "Leilão"
  end
end
