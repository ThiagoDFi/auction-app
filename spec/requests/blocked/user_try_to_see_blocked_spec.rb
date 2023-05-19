require 'rails_helper'

describe 'usuario tenta acessar restrições' do
  it 'mas não tem acesso' do
    #Arrange
    user = User.create!(name: 'Beatriz', email: 'beatriz@gmail.com', password: 'password',
                        registry_code: '08978831010', role: 'customer')

    #Act
    login_as(user)
    get blockeds_path

    #Assert
    expect(response).to redirect_to(root_path)
  end
end
