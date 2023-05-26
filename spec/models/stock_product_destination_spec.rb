require 'rails_helper'

RSpec.describe StockProductDestination, type: :model do
  describe '#available?' do
    it 'true se não tiver destino' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000,
        description: 'Alguma descrição')
      supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
        registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
        city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70,
        width: 75, depth: 80, sku: 'CGMER-XPTO-888', supplier: supplier)
    
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse,
        product_model: product)
    
      # Assert
      expect(stock_product.available?).to eq true
    end
  
    it 'false se tiver destino' do
      # Arrange
      user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000,
        description: 'Alguma descrição')
      supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
        registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
        city: 'Bauru', state: 'SP', email: 'contato@acme.com')
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
        estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', weight: 5, height: 70,
        width: 75, depth: 80, sku: 'CGMER-XPTO-888', supplier: supplier)
    
      # Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse,
        product_model: product)
      stock_product.create_stock_product_destination!(recipient: 'Joao',
        address: 'Rua do Joao')
    
      # Assert
      expect(stock_product.available?).to eq false
    end
  end
end
