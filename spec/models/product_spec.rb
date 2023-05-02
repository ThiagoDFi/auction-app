require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#Valid?' do
    it 'adiciona errors quando nome está vazio' do
      #Arrange
      product = Product.new(name: '')

      #Act
      product.valid?
      result = product.errors.include?(:name)
      #Assert
      expect(result).to be true 
    end
    it 'adiciona errors quando descrição é vazio' do
      #Arrange
      product = Product.new(description: '')

      #Act
      product.valid?
      result = product.errors.include?(:description)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando peso é vazio' do
      #Arrange
      product = Product.new(weight: '')

      #Act
      product.valid?
      result = product.errors.include?(:weight)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando largura é vazio' do
      #Arrange
      product = Product.new(width: '')

      #Act
      product.valid?
      result = product.errors.include?(:width)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando Altura é vazio' do
      #Arrange
      product = Product.new(height: '')

      #Act
      product.valid?
      result = product.errors.include?(:height)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando profundidade é vazio' do
      #Arrange
      product = Product.new(depth: '')

      #Act
      product.valid?
      result = product.errors.include?(:depth)

      #Assert
      expect(result).to be true
    end
    it 'adiciona errors quando categoria é vazio' do
      #Arrange
      product = Product.new(category: '')

      #Act
      product.valid?
      result = product.errors.include?(:category)
      
      #Assert
      expect(result).to be true
    end
    it 'deve ter um código' do
      #Arrange
      product = Product.new(name: 'Tv 40', description: 'Tv de ultima geração LED 4K',
                                weight: 80, width: 3, height: 60, depth: 5, category: 'Tecnologia')
      #Act
      result = product.valid?

      #Assert
      expect(result).to be true
    end
  end
end