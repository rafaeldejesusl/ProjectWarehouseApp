require 'rails_helper'

describe 'Usuário edita um fornecedor' do
	it 'a partir da página de detalhes' do
		# Arrange
		Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

		# Act
		visit root_path
		click_on('Fornecedores')
    click_on('Samsung')	
    click_on('Editar')

		# Assert
		expect(page).to have_content 'Editar Fornecedor'
		expect(page).to have_field('Nome Fantasia', with: 'Samsung')
		expect(page).to have_field('Razão Social', with: 'Samsung Eletronicos LTDA')
		expect(page).to have_field('CNPJ', with: '7317108000151')
		expect(page).to have_field('Endereço', with: 'Av Nacoes Unidas, 1000')
		expect(page).to have_field('Cidade', with: 'São Paulo')
		expect(page).to have_field('Estado', with: 'SP')
		expect(page).to have_field('E-mail', with: 'sac@samsung.com.br')
	end

  it 'com sucesso' do
    # Arrange
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
  
    # Act
    visit root_path
		click_on('Fornecedores')
    click_on('Samsung')	
    click_on('Editar')
    fill_in 'Nome Fantasia', with: 'Apple'
    fill_in 'Razão Social', with: 'Apple Inc'
    fill_in 'Endereço', with: 'Avenida dos Galpões, 500'
    fill_in 'CNPJ', with: '7700000000000'
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Apple'
    expect(page).to have_content 'Endereço: Avenida dos Galpões, 500'
    expect(page).to have_content 'Razão Social: Apple Inc'
    expect(page).to have_content 'CNPJ: 7700000000000'
  end

  it 'e mantém os campos obrigatórios' do
    # Arrange
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
  
    # Act
    visit root_path
		click_on('Fornecedores')
    click_on('Samsung')	
    click_on('Editar')
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content 'Não foi possível atualizar o fornecedor'
  end
end