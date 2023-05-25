require 'rails_helper'

describe 'Usuário edita pedido' do
	it 'e deve estar autenticado' do
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
		visit edit_order_path(first_order.id)

		# Assert
		expect(current_path).to eq new_user_session_path
	end

	it 'com sucesso' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
			registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
			city: 'São Paulo', state: 'SP', email: 'contato@lg.com.br')
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
		click_on 'Editar'
		fill_in 'Data Prevista de Entrega', with: '12/12/2042'
		select 'LG do Brasil LTDA', from: 'Fornecedor'
		click_on 'Gravar'

		# Assert
		expect(page).to have_content 'Pedido atualizado com sucesso.'
		expect(page).to have_content 'Fornecedor: LG do Brasil LTDA'
		expect(page).to have_content 'Data Prevista de Entrega: 12/12/2042'
	end

	it 'caso seja o responsável' do
		# Arrange
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		other_user = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
			registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
			city: 'São Paulo', state: 'SP', email: 'contato@lg.com.br')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now)
		
		# Act
		login_as(other_user)
		visit edit_order_path(first_order.id)

		# Assert
		expect(current_path).to eq root_path
	end
end