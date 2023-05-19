require 'rails_helper'

RSpec.describe Blocked, type: :model do
  describe '#valid?' do
    it 'o cpf deve ser preenchido' do
      #Arrange
      block = Blocked.new(registry_code: '')

      #Act
      block.valid?
      result = block.errors.include?(:registry_code)

      #Assert
      expect(result).to be true
    end
  end
end
