require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'deve ter um código' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000,
        description: 'Alguma descrição')
      supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
        registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
        city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01')
  
      # Act
      result = order.valid?
  
      # Assert
      expect(result).to be true
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000,
        description: 'Alguma descrição')
      supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
        registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
        city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01')
  
      # Act
      order.save!
      result = order.code
  
      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'diferente do anterior' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000,
        description: 'Alguma descrição')
      supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
        registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
        city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-10-01')
      second_order = Order.new(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: '2022-11-15')
  
      # Act
      second_order.save!
  
      # Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
