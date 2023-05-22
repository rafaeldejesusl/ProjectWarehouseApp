require 'rails_helper'

describe 'Usuário busca por um pedido' do
	it 'a partir do menu' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

		# Act
		login_as(user)
		visit root_path

		# Assert
		within('nav') do
			expect(page).to have_field 'Buscar Pedido'
			expect(page).to have_button 'Buscar'
		end
	end

	it 'e deve estar autenticado' do
		# Arrange

		# Act
		visit root_path

		# Assert
		within('nav') do
			expect(page).not_to have_field 'Buscar Pedido'
			expect(page).not_to have_button 'Buscar'
		end
	end

  it 'e encontra um pedido' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now)

		# Act
		login_as(user)
		visit root_path
		fill_in 'Buscar Pedido', with: order.code
		click_on 'Buscar'

		# Assert
		expect(page).to have_content "Resultados da Busca por: #{order.code}"
		expect(page).to have_content '1 pedido encontrado'
		expect(page).to have_content "Código: #{order.code}"
		expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
		expect(page).to have_content "Fornecedor: ACME LTDA"
	end
end