require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do

    #Arrange

    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'CPF', with: '52125951002'
    fill_in 'E-mail', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    #Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Olá Thiago'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.name). to eq 'Thiago'
  end
  it 'e o CPF do cadastro está suspenso' do

    #Arrange
    block = Blocked.create!(registry_code: '52125951002')

    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Thiago'
    fill_in 'CPF', with: '52125951002'
    fill_in 'E-mail', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    #Assert
    expect(page).to have_content "CPF está suspenso"
  end
end