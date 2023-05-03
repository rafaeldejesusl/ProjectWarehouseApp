require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
	it 'e vê informações adicionais' do
		# Arrange
		Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
		# Act
		visit root_path
		click_on('Fornecedores')
    click_on('Samsung')	

		# Assert
		expect(page).to have_content('Samsung')
		expect(page).to have_content('Razão Social: Samsung Eletronicos LTDA')
		expect(page).to have_content('Cidade: São Paulo')
		expect(page).to have_content('Estado: SP')
		expect(page).to have_content('Endereço: Av Nacoes Unidas, 1000')
		expect(page).to have_content('CNPJ: 7317108000151')
    expect(page).to have_content('E-mail: sac@samsung.com.br')
	end

  it 'e volta para a tela inicial' do
    # Arrange
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
  
    # Act
    visit root_path
		click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Voltar'
  
    # Assert
    expect(current_path).to eq('/')
  end
end