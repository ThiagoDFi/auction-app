require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange
   User.create!(name: 'Thiago', registry_code: '52125951002', email: 'thiago@email.com',
                 password: 'password') 

    #Act
    visit root_path
    click_on 'Entrar'
    within('form') do
    fill_in 'E-mail', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    end

    #Assert
    expect(page).to have_content "Login efetuado com sucesso."
    within('nav') do
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_content 'Sair'
    expect(page).to have_content 'thiago@email.com'
    end
  end
  it 'e faz logout' do
    #Arrange
    User.create!(name: 'Thiago', registry_code: '52125951002', email: 'thiago@email.com',
                 password: 'password')

    #Act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'thiago@email.com'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    #Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_content 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joao@email.com'
  end
end