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
			estimated_delivery_date: 1.day.from_now)
		second_order = Order.create!(user: other_user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now)
		third_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.week.from_now)
		
		# Act
		login_as(user)
		visit root_path
		click_on 'Meus Pedidos'

		# Assert
		expect(page).to have_content first_order.code
		expect(page).not_to have_content second_order.code
		expect(page).to have_content third_order.code
	end
end