require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
	it 'com sucesso' do
		# Arrange
		user = User.create!(email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
			registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
			city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
		other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
			registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
			city: 'São Paulo', state: 'SP', email: 'contato@lg.com.br')

		# Act
		login_as(user)
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: 'TV 40 polegadas'
		fill_in 'Peso', with: 1000
		fill_in 'Altura', with: 60
		fill_in 'Largura', with: 90
		fill_in 'Profundidade', with: 10
		fill_in 'SKU', with: 'TV40-SAMS-XPTO'
		select 'Samsung', from: 'Fornecedor'
		click_on 'Enviar'

		# Assert
		expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
		expect(page).to have_content 'TV 40 polegadas'
		expect(page).to have_content 'Fornecedor: Samsung'
		expect(page).to have_content 'SKU: TV40-SAMS-XPTO'
		expect(page).to have_content 'Dimensão: 60cm x 90cm x 10cm'
		expect(page).to have_content 'Peso: 1000g'
	end

  it 'com dados incompletos' do
		# Arrange
		user = User.create!(email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
			registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
			city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

		# Act
		login_as(user)
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: ''
		fill_in 'SKU', with: ''
		click_on 'Enviar'

		# Assert
		expect(page).to have_content 'Não foi possível cadastrar o modelo de produto'
	end
end