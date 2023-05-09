require 'rails_helper'

describe 'Usuário cadastra um pedido' do
	it 'com sucesso' do
		# Arrange
		user = User.create!(name: 'Sergio', email: 'sergio@email.com', password: '12345678')
		Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
			registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
			city: 'São Paulo', state: 'SP', email: 'contato@lg.com.br')
		supplier = Supplier.create!(brand_name: 'ACME', corporate_name: 'ACME LTDA',
			registration_number: '3447216000102', full_address: 'Av das Palmas, 100',
			city: 'Bauru', state: 'SP', email: 'contato@acme.com')
		Warehouse.create!(name: 'Cuiaba', code: 'CWB', city: 'Cuiabá',
			area: 10_000, address: 'Av dos jacarés, 1000', cep: '56000-000',
			description: 'Galpão no centro do país')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')

		# Act
		login_as(user)
		visit root_path
		click_on 'Registrar Pedido'
		select warehouse.name, from: 'Galpão Destino'
		select supplier.corporate_name, from: 'Fornecedor'
		fill_in 'Data Prevista', with: '20/12/2022'
		click_on 'Gravar'

		# Assert
		expect(page).to have_content 'Pedido registrado com sucesso.'
		expect(page).to have_content 'Galpão Destino: Aeroporto SP'
		expect(page).to have_content 'Fornecedor: ACME LTDA'
		expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
		expect(page).to have_content 'Usuário Responsável: Sergio | sergio@email.com'
		expect(page).not_to have_content 'Galpão Destino: Cuiaba'
		expect(page).not_to have_content 'Fornecedor: LG do Brasil LTDA'
	end

  it 'e deve estar autenticado' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Registrar Pedido'
  
    # Assert
    expect(current_path).to eq new_user_session_path
  end
end