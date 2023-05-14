require 'rails_helper'

RSpec.describe ProductsHelper, type: :helper do
  describe '#product_class' do
    it 'Deve retornar as dimensões no formato esperado' do
      #Arrange
      height = 10
      width = 20
      depth = 30
      
      #Act
      result = dimension(height,width,depth)

      #Assert
      expect(result).to eq("10cm x 20cm x 30cm")
    end
  end
end
