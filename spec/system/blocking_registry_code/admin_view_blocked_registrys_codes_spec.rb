require 'rails_helper'

describe 'Admin visualiza painel de restrição' do
  it 'a partir da tela inicial' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    #Act
    login_as(admin)
    visit root_path
    click_on "Restrições"

    #Assert
    expect(page).to have_content "Painel de restrições"
  end
end