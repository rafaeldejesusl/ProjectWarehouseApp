require 'rails_helper'

describe 'Usuário informa novo status de pedido' do
	it 'e pedido foi entregue' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer',
			weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		OrderItem.create!(order: order, product_model: product, quantity: 5)
		
		# Act
		login_as user
		visit root_path
		click_on 'Meus Pedidos'
		click_on order.code
		click_on 'Marcar como ENTREGUE'
	
		# Assert
		expect(current_path).to eq order_path(order.id)
		expect(page).to have_content 'Situação do Pedido: Entregue'
		expect(page).not_to have_content 'Marcar como ENTREGUE'
		expect(page).not_to have_content 'Marcar como CANCELADO'
		expect(StockProduct.count).to eq 5
		stock = StockProduct.where(product_model: product, warehouse: warehouse)
		expect(stock.length).to eq 5
	end

	it 'e pedido foi cancelado' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer',
			weight: 5, height: 100, width: 70, depth: 75, sku: 'CAD-GAMER-1234')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		OrderItem.create!(order: order, product_model: product, quantity: 5)
		
		# Act
		login_as user
		visit root_path
		click_on 'Meus Pedidos'
		click_on order.code
		click_on 'Marcar como CANCELADO'
	
		# Assert
		expect(current_path).to eq order_path(order.id)
		expect(page).to have_content 'Situação do Pedido: Cancelado'
		expect(StockProduct.count).to eq 0
	end
end