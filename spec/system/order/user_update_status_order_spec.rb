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
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		
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
	end

	it 'e pedido foi cancelado' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
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
		click_on 'Marcar como CANCELADO'

		# Assert
		expect(current_path).to eq order_path(order.id)
		expect(page).to have_content 'Situação do Pedido: Cancelado'
	end
end