require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
	it 'com sucesso' do
		# Arrange
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
		registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
		city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		product_a = ProductModel.create!(name: 'Produto A', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-A')
		product_b = ProductModel.create!(name: 'Produto B', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-B')
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		
		# Act
		login_as user
		visit root_path
		click_on 'Meus Pedidos'
		click_on order.code
		click_on 'Adicionar Item'
		select 'Produto A', from: 'Produto'
		fill_in 'Quantidade', with: '8'
		click_on 'Gravar'

		# Assert
		expect(current_path).to eq order_path(order.id)
		expect(page).to have_content 'Item adicionado com sucesso'
		expect(page).to have_content '8 x Produto A'
	end

  it 'e não vê produtos de outro fornecedor' do
		# Arrange
		supplier_a = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
		registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
		city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		supplier_b = Supplier.create!(brand_name: 'Spark', corporate_name: 'Spark Industries Brasil LTDA',
			registration_number: '1907455909000', full_address: 'Torre da Indústria, 1',
			city: 'Teresina', state: 'PI', email: 'vendas@spark.com.br')
		product_a = ProductModel.create!(name: 'Produto A', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier_a, sku: 'PRODUTO-A')
		product_b = ProductModel.create!(name: 'Produto B', weight: 1, height: 10,
			width: 20, depth: 30, supplier: supplier_b, sku: 'PRODUTO-B')
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier_a,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		
		# Act
		login_as user
		visit root_path
		click_on 'Meus Pedidos'
		click_on order.code
		click_on 'Adicionar Item'

		# Assert
		expect(page).not_to have_content 'Produto B'
		expect(page).to have_content 'Produto A'
	end
end