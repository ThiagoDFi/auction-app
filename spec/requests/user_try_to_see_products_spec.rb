require 'rails_helper'

describe 'Usuario tenta visualizar os produtos' do
  it 'mas não tem permissão para ver a lista de produtos' do
    #Arrange
    user = User.create!(name: 'Beatriz', email: 'beatriz@gmail.com', password: 'password',
                        registry_code: '08978831010', role: 'customer')

    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                          weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!

    #Act
    login_as(user)
    get products_path

    #Assert
    expect(response).to redirect_to(root_path)
  end
  it 'mas não tem permissão para ver detalhes de produto' do
    #Arrange
    user = User.create!(name: 'Beatriz', email: 'beatriz@gmail.com', password: 'password',
                        registry_code: '08978831010', role: 'customer')

    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                          weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!

    #Act
    login_as(user)
    get product_path(product.id)

    #Assert
    expect(response).to redirect_to(root_path)
  end
end