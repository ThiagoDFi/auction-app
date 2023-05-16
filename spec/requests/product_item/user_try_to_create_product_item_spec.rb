require 'rails_helper'

describe 'Usuario tenta criar um product item' do
  it 'mas não tem permissão' do
    #Arrange
    user = User.create!(name: 'Beatriz', email: 'beatriz@gmail.com', password: 'password',
                        registry_code: '08978831010', role: 'customer')

    product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                           weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia', status: :inactive)

    product.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
    product.save!

    auction_lot = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                     minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                     admin_record: 'pedro@leilaodogalpao.com.br',
                                     admin_approve: 'admin@leilaodogalpao.com.br',
                                     status: :active)

    #Act
    login_as(user)
    post(auction_lot_product_items_path(auction_lot), params: { product_item: {product_id: product.id, auction_lot: auction_lot}})

    #Assert
    expect(response).to redirect_to(root_path)
  end
end