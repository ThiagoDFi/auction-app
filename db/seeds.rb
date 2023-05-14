# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

thiago = User.create!(name: 'Pedro', email: 'thiago@leilaodogalpao.com.br', password: 'password',
                     registry_code: '31350282081', role: 'admin')

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

auction_lot1 = AuctionLot.create!(start_date: Date.today, end_date: 2.months.from_now,
                                 minimum_value: 1000, diff_value: 300, code: 'GRU123456',
                                 admin_record: 'pedro@leilaodogalpao.com.br',
                                 admin_approve: 'admin@leilaodogalpao.com.br',
                                 status: :active)

prod1 = ProductItem.create!(product: product1, auction_lot: auction_lot)