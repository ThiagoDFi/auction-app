require 'rails_helper'

describe 'Admin remove um bloqueio' do
  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
    registry_code: '52059095018', role: "admin")

    user = User.create!(name: 'thiago', email: 'thiago@teste.com', password: 'password',
   registry_code: '93224124024', role: "customer")

   user = User.create!(name: 'Maria', email: 'maria@teste.com', password: 'password',
   registry_code: '91257683012', role: "customer")

    block = Blocked.create!(registry_code: 93224124024)
    block = Blocked.create!(registry_code: 91257683012)

    #Act
    login_as(admin)
    visit root_path
    click_on 'Restrições'
    click_button 'Remover', id: 'blocked_1'

    #Assert
    expect(page).to have_content "O CPF foi desbloqueado com sucesso."
    expect(page).to have_content "Numero: 91257683012"
    expect(page).not_to have_content "Numero: 93224124024"
  end
end