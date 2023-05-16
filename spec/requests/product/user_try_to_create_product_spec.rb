require 'rails_helper'

describe 'Usuario tenta criar um produto' do
  it 'mas não tem permissão' do
    #Arrange
    user = User.create!(name: 'Fernando', email: 'fernando@email.com', password: 'password',
                        registry_code: '75974186044', role: 'customer')

    image_file = { io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')),
                        filename: 'iphone.jpeg',
                        content_type: 'image/jpeg' }
    #Act
    login_as(user)
    post(products_path, params: { product: {name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
    weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', photo: image_file}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end
