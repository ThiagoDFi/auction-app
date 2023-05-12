require 'rails_helper'

describe 'Usuario tenta criar um auction lot' do
  it 'mas não tem acesso' do
    #Arrange
    user = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                        registry_code: '07699032071', role: 'customer')

    #Act
    login_as(user)
    post(auction_lots_path, params: {auction_lot: { end_date: '2023-06-30', start_date: '2023-06-05', minimum_value: 100, diff_value: 10, admin_record: 'pedro@leilaodogalpao.com.br'}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end
