require 'rails_helper'

describe 'Usuario tenta bloquear um cpf' do
  it 'mas não tem permissão' do
    #Arrange
    user = User.create!(name: 'Fernando', email: 'fernando@email.com', password: 'password',
                        registry_code: '75974186044', role: 'customer')

    #Act
    login_as(user)
    post(blockeds_path, params: { blocked: {registry_code: '29582708077'}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end