require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
	it 'e deve estar autenticado' do
		# Arrange
		
		# Act
		visit root_path
		click_on 'Meus Pedidos'

		# Assert
		expect(current_path).to eq new_user_session_path
	end

		it 'e não vê outros pedidos' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		other_user = User.create!(name: 'Carla', email: 'carla@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: 'pending')
		second_order = Order.create!(user: other_user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: 'delivered')
		third_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.week.from_now, status: 'canceled')
		
		# Act
		login_as(user)
		visit root_path
		click_on 'Meus Pedidos'

		# Assert
		expect(page).to have_content first_order.code
		expect(page).not_to have_content second_order.code
		expect(page).to have_content third_order.code
		expect(page).to have_content 'Pendente'
		expect(page).not_to have_content 'Entregue'
		expect(page).to have_content 'Cancelado'
	end

	it 'e visita um pedido' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now)
		
		# Act
		login_as(user)
		visit root_path
		click_on 'Meus Pedidos'
		click_on first_order.code

		# Assert
		expect(page).to have_content 'Detalhes do Pedido'
		expect(page).to have_content first_order.code
		expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
		expect(page).to have_content 'Fornecedor: ACME LTDA'
		formatted_date = I18n.localize(1.day.from_now.to_date)
		expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
	end

	it 'e não visita pedidos de outros usuários' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		other_user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now)
		
		# Act
		login_as(other_user)
		visit order_path(first_order.id)

		# Assert
		expect(current_path).not_to eq order_path(first_order.id)
		expect(current_path).to eq root_path
		expect(page).to have_content 'Você não possui acesso a este pedido.'
	end

	it 'e vê itens do pedido' do
		# Arrange
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		product_a = ProductModel.create!(name: 'Produto A', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-A')
		product_b = ProductModel.create!(name: 'Produto B', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-B')
		product_c = ProductModel.create!(name: 'Produto C', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-C')
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		OrderItem.create!(product_model: product_a, order: order, quantity: 19)
		OrderItem.create!(product_model: product_b, order: order, quantity: 12)
	
		# Act
		login_as user
		visit root_path
		click_on 'Meus Pedidos'
		click_on order.code
	
		# Assert	
		expect(page).to have_content 'Itens do Pedido'
		expect(page).to have_content '19 x Produto A'
		expect(page).to have_content '12 x Produto B'
	end
end