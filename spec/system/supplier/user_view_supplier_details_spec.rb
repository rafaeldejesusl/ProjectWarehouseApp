require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
	it 'e vê informações adicionais' do
		# Arrange
    user = User.create!(email: 'joao@email.com', password: 'password')
		supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    other_supplier = Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
      registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
      city: 'Guarulhos', state: 'SP', email: 'contato@lg.com.br')
    ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
      sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
    ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
      depth: 20, sku: 'SOU71-SAMSU-NOIZ77', supplier: other_supplier)
    
		# Act
    login_as(user)
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
    expect(page).to have_content('TV 32')
    expect(page).not_to have_content('SoundBar 7.1 Surround')
	end

  it 'e volta para a tela inicial' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'password')
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
  
    # Act
    login_as(user)
    visit root_path
		click_on 'Fornecedores'
    click_on 'Samsung'
    click_on 'Voltar'
  
    # Assert
    expect(current_path).to eq('/')
  end
end