require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    it 'adiciona errors quando nome está vazio' do
      #Arrange
      user = User.new(name: '')

      #Act
      user.valid?
      result = user.errors.include?(:name)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando cpf está vazio' do
      #Arrange
      user = User.new(email: '')

      #Act
      user.valid?
      result = user.errors.include?(:email)

      #Assert
      expect(result).to be true
    end
    it 'adiciona a role "customer" para user sem o dominio correto' do
      #Arrange
      user = User.create!(name: 'Pedro', email: 'pedro@gmail.com.br', password: 'password',
                          registry_code: '31350282081')

      #Act
      result = user.valid?

      #Assert
      expect(result).to be true
      user = User.last
      expect(user.role).to eq 'customer'
    end
    it 'adiciona a role "admin" para user com o dominio correto' do
      #Arrange
      user = User.create!(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '31350282081')

      #Act
      result = user.valid?

      #Assert
      expect(result).to be true
      user = User.last
      expect(user.role).to eq 'admin'
    end
    it 'CPF inválido retorna erro' do
      #Arrange
      user = User.new(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '78451222457')

      #Act
      user.valid?
      result = user.errors.include?(:registry_code)
      
      #Assert
      expect(result).to be true
    end
  end
  describe '#set_admin' do 
    it 'Usuario recebe a role admin se tiver o dominio correto' do
      #Arrange
      user = User.new(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
                    registry_code: '31350282081')

      #Act
      result = user.valid?

      #Assert
      expect(result).to be true
      expect(user.role).to eq 'admin'
    end
    it 'Usuario sem do dominio do leilao rece role customer' do
      #Arrange
      user = User.new(name: 'Pedro', email: 'pedro@gmail.com.br', password: 'password',
      registry_code: '31350282081')

      #Act
      result = user.valid?

      #Assert
      expect(result).to be true
      expect(user.role).to eq 'customer'
    end
    it 'adiciona erroe quando CPF é suspenso' do
      #Arrange
      block = Blocked.create!(registry_code: '78451222457')

      user = User.new(name: 'Pedro', email: 'pedro@leilaodogalpao.com.br', password: 'password',
      registry_code: '78451222457')

      #Act
      user.valid?
      result = user.errors.include?(:registry_code)

      #Assert
      expect(result).to be true
    end
  end
end
