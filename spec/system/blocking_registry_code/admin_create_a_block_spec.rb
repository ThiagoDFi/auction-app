require 'rails_helper'

describe 'Admin cadastra um bloqueio' do
  it 'com sucesso' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    user = User.create!(name: 'thiago', email: 'thiago@teste.com', password: 'password',
                        registry_code: '93224124024', role: "customer")

    #Act
    login_as(admin)
    visit root_path
    click_on "Restrições"
    fill_in 'Busque um CPF', with: '93224124024'
    click_on 'Procurar'
    click_on 'Bloquear'

    #Assert
    expect(page).to have_content "CPFs Bloqueados:"
    expect(page).to have_content "Numero: 93224124024"
  end
  it 'e não tem CPFs bloqueado até o momento' do
    #Arrange
    admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '52059095018', role: "admin")

    #act
    login_as(admin)
    visit root_path
    click_on "Restrições"

    #Assert
    expect(page).to have_content "Nenhum CPF bloqueado até o momento."
  end
end
