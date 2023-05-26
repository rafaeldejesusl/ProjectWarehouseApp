require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    it 'false quando não tiver quantidade' do
      # Arrange
      order_item = OrderItem.new()
    
      # Act
      order_item.valid?
    
      # Assert
      expect(order_item.errors.include?(:quantity)).to be true
      expect(order_item.errors[:quantity]).to include('não pode ficar em branco')
    end
  end
end
