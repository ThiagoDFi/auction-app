# Criação de usuarios ADM

thiagoadm = User.create!(name: 'Thiago', email: 'thiago@leilaodogalpao.com.br', password: 'password',
                         registry_code: '31350282081', role: 'admin')

admin = User.create!(name: 'admin', email: 'admin@leilaodogalpao.com.br', password: 'password',
                         registry_code: '26975119031', role: 'admin')

# Criação usuarios normais

maria = User.create!(name: 'Maria', email: 'maria@gmail.com', password: 'password',
                         registry_code: '17993621089', role: 'customer')

carlos = User.create!(name: 'Carlos', email: 'carlos@gmail.com', password: 'password',
                         registry_code: '47749721002', role: 'customer')

# Criação de produtos

product1 = Product.new(name: 'Iphone 13', description: 'Iphone celular de ultima geração da Apple',
                       weight: 4, width: 10, height: 5, depth: 2, category: 'Celular', status: :active)

product1.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'iphone.jpeg')), filename: 'iphone.jpeg', content_type: 'image/jpeg')
product1.save!

product2 = Product.new(name: 'Playstation 5', description: 'Video Game ultima geração',
          weight: 800, width: 10, height: 60, depth: 10, category: 'Tecnologia', status: :active)                     
product2.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'play5.jpeg')), filename: 'play5.jpeg', content_type: 'image/jpeg')
product2.save! 

product3 = Product.new(name: 'Cadeira Gamer', description: 'Cadeira Gamer de alta qualidade',
                       weight: 2000, width: 80, height: 100, depth: 45, category: 'Mobiliário', status: :active)                     
product3.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'cadeira.jpeg')), filename: 'cadeira.jpeg', content_type: 'image/jpeg')
product3.save!

product4 = Product.new(name: 'Caneca Stanley', description: 'Caneca que segura a temperatura da sua bebida',
                       weight: 300, width: 6, height: 15, depth: 15, category: 'Outros', status: :active)                     
product4.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'caneca.jpeg')), filename: 'caneca.jpeg', content_type: 'image/jpeg')
product4.save!

product5 = Product.new(name: 'jogo de copos', description: 'lindo jogo de copos para sua casa',
                       weight: 100, width: 6, height: 10, depth: 15, category: 'Outros', status: :active)                     
product5.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'copos.jpeg')), filename: 'copos.jpeg', content_type: 'image/jpeg')
product5.save!

product6 = Product.new(name: 'Funkpop do Grogu', description: 'FunkPOP do Grogu',
                       weight: 100, width: 10, height: 20, depth: 15, category: 'Outros', status: :active)                     
product6.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'funkpop.jpeg')), filename: 'funkpop.jpeg', content_type: 'image/jpeg')
product6.save!

product7 = Product.new(name: 'Caixa JBL', description: 'Caixa de som JBL, extrema qualidade',
                       weight: 800, width: 60, height: 30, depth: 45, category: 'Tecnologia', status: :active)                     
product7.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'jbl.jpeg')), filename: 'jbl.jpeg', content_type: 'image/jpeg')
product7.save!

product8 = Product.new(name: 'Monitor gamer', description: 'Monitor Benq Gamer',
                       weight: 600, width: 60, height: 40, depth: 7, category: 'Tecnologia', status: :active)                     
product8.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'monitor.jpeg')), filename: 'monitor.jpeg', content_type: 'image/jpeg')
product8.save!

product9 = Product.new(name: 'Livro Hobbit', description: 'Livro do Hobbit, ótima leitura',
                       weight: 100, width: 10, height: 45, depth: 4, category: 'Livro', status: :active)                     
product9.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'livro.jpeg')), filename: 'livro.jpeg', content_type: 'image/jpeg')
product9.save!

product10 = Product.new(name: 'Notebook Samsung', description: 'i7, 1GB 16RAM',
                       weight: 100, width: 10, height: 45, depth: 4, category: 'Tecnologia', status: :active)                     
product10.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'notebook.jpeg')), filename: 'notebook.jpeg', content_type: 'image/jpeg')
product10.save!

product11 = Product.new(name: 'Teclado Gamer', description: 'Teclado mecanico para gamers',
                       weight: 600, width: 40, height: 10, depth: 2, category: 'Tecnologia', status: :active)                     
product11.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'teclado.jpeg')), filename: 'teclado.jpeg', content_type: 'image/jpeg')
product11.save!

product12 = Product.new(name: 'Tv 42 Samsung 4k', description: 'Tv 42 polegadas, Samsung ',
                       weight: 600, width: 40, height: 10, depth: 2, category: 'Tecnologia', status: :active)                     
product12.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'tv.jpeg')), filename: 'tv.jpeg', content_type: 'image/jpeg')
product12.save!

product13 = Product.new(name: 'Tenis Air Jordan', description: 'Tenis Nike Air Jordan ',
                       weight: 200, width: 20, height: 10, depth: 45, category: 'Vestuario', status: :active)                     
product13.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'tenis.jpeg')), filename: 'tenis.jpeg', content_type: 'image/jpeg')
product13.save!

product14 = Product.new(name: 'Headset Hyperx', description: 'Headset gamer 7.1',
                       weight: 200, width: 20, height: 10, depth: 45, category: 'Tecnologia', status: :active)                     
product14.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'headset.jpeg')), filename: 'headset.jpeg', content_type: 'image/jpeg')
product14.save!

product15 = Product.new(name: 'Apple watch', description: 'Apple watch 42mm',
                       weight: 100, width: 5, height: 2, depth: 3, category: 'Tecnologia', status: :active)                     
product15.photo.attach(io: File.open(Rails.root.join('spec', 'support', 'watch.jpeg')), filename: 'watch.jpeg', content_type: 'image/jpeg')
product15.save!

# Criação dos lotes Ativos e Product_items

auction_lot1 = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem1 = ProductItem.create!(product: product1, auction_lot: auction_lot1)

product1.update(status: 1)

auction_lot2 = AuctionLot.create!(start_date: 2.days.ago, end_date: 1.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'BRA123456',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem2 = ProductItem.create!(product: product2, auction_lot: auction_lot2)
proditem3 = ProductItem.create!(product: product3, auction_lot: auction_lot2)

product2.update(status: 1)
product3.update(status: 1)

# Criação de lotes ativos futuros e Product_items

auction_lot3 = AuctionLot.create!(start_date: 2.days.from_now, end_date: 2.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'LOT987456',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem4 = ProductItem.create!(product: product4, auction_lot: auction_lot3)

product4.update(status: 1)

auction_lot4 = AuctionLot.create!(start_date: 6.days.from_now, end_date: 1.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'GDH894512',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem5 = ProductItem.create!(product: product5, auction_lot: auction_lot4)

product5.update(status: 1)

# Criação de lotes aguardando a aprovação

auction_lot5 = AuctionLot.create!(start_date: 4.days.from_now, end_date: 45.days.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'DSA874632',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 status: :draft)

proditem6 = ProductItem.create!(product: product6, auction_lot: auction_lot5)

product6.update(status: 1)

auction_lot6 = AuctionLot.create!(start_date: 8.days.from_now, end_date: 45.days.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'POS965420',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 status: :draft)

proditem7 = ProductItem.create!(product: product7, auction_lot: auction_lot6)

product7.update(status: 1)

# Criação de lotes com lance

auction_lot7 = AuctionLot.create!(start_date: 40.days.ago, end_date: 2.days.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'FBS851423',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem8 = ProductItem.create!(product: product8, auction_lot: auction_lot7)

product8.update(status: 1)

bid1 = Bid.create!(amount: 1100, user: maria, auction_lot: auction_lot7)
bid2 = Bid.create!(amount: 1500, user: carlos, auction_lot: auction_lot7)

auction_lot7.update(end_date: 3.days.ago)

auction_lot8 = AuctionLot.create!(start_date: 40.days.ago, end_date: 2.days.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'BGS874536',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem9 = ProductItem.create!(product: product9, auction_lot: auction_lot8)
proditem10 = ProductItem.create!(product: product10, auction_lot: auction_lot8)

product9.update(status: 1)
product10.update(status: 1)

bid1 = Bid.create!(amount: 1050, user: carlos, auction_lot: auction_lot8)
bid2 = Bid.create!(amount: 1400, user: maria, auction_lot: auction_lot8)

auction_lot8.update(end_date: 2.days.ago)

# Criação lotes sem lance
auction_lot9 = AuctionLot.create!(start_date: 40.days.ago, end_date: 2.days.ago,
                                 minimum_value: 1000, diff_value: 300, code: 'LKM259147',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem11 = ProductItem.create!(product: product11, auction_lot: auction_lot9)

product11.update(status: 1)

auction_lot10 = AuctionLot.create!(start_date: 40.days.ago, end_date: 2.days.ago,
                                 minimum_value: 1000, diff_value: 300, code: 'UDF127845',
                                 admin_record: 'thiago@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

proditem12 = ProductItem.create!(product: product12, auction_lot: auction_lot10)

product12.update(status: 1)







