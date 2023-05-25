require 'rails_helper'

describe 'Usuário edita pedido' do
	it 'e não é o dono' do
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
		patch(order_path(first_order.id), params: { order: { supplier_id: 3 } })

		# Assert
		expect(response).to redirect_to(root_path)
	end
end