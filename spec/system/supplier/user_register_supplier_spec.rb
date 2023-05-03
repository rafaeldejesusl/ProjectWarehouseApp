require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
	it 'a partir da tela inicial' do
		# Arrange

		# Act
		visit root_path
    click_on 'Fornecedores'
		click_on 'Cadastrar Fornecedor'

		# Assert
		expect(page).to have_field('Nome Fantasia')
		expect(page).to have_field('Razão Social')
		expect(page).to have_field('CNPJ')
		expect(page).to have_field('Endereço')
		expect(page).to have_field('Cidade')
		expect(page).to have_field('Estado')
		expect(page).to have_field('E-mail')
	end

  it 'com sucesso' do
    # Arrange
  
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome Fantasia', with: 'Samsung'
    fill_in 'Razão Social', with: 'Samsung Eletronicos LTDA'
    fill_in 'CNPJ', with: '7317108000151'
    fill_in 'Endereço', with: 'Av Nacoes Unidas, 1000'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'sac@samsung.com.br'
    click_on 'Enviar'
  
    # Assert
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Samsung Eletronicos LTDA'
    expect(page).to have_content 'São Paulo'
  end

  it 'com dados incompletos' do
    # Arrange
  
    # Act
    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    click_on 'Enviar'
  
    # Assert
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
  end
end