require 'rails_helper'

describe 'Usuario tenta remover product item' do
  it 'e não tem permissão' do
    #Arrange
    user = User.create!(name: 'Beatriz', email: 'beatriz@gmail.com', password: 'password',
                        registry_code: '08978831010', role: 'customer')

    product = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
                           weight: 70, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :inactive)                     

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
    product.save! 

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br',
                                     admin_approve: 'admin@leilaodogalpao.com.br',
                                     status: :active)

    product_item = ProductItem.create!(product: product, auction_lot: auction_lot)

    #Act
    login_as(user)
    delete auction_lot_product_item_path(auction_lot, product_item)

    #Assert
    expect(response).to redirect_to(root_path)
  end
end