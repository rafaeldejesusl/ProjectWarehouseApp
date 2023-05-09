require 'rails_helper'

describe 'Usuário vê fornecedores' do
	it 'se estiver autenticado' do
    # Arrange
  
    # Act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
  
    # Assert
    expect(current_path).to eq new_user_session_path
  end
  
  it 'a partir do menu' do
		# Arrange
    user = User.create!(email: 'joao@email.com', password: 'password')

		# Act
    login_as(user)
		visit root_path
		within('nav') do
			click_on 'Fornecedores'
		end

		# Assert
		expect(current_path).to eq suppliers_path
	end

  it 'com sucesso' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'password')
    Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
      registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
      city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
      registration_number: '4356508000149', full_address: 'Av Ibirapuera, 300',
      city: 'Guarulhos', state: 'SP', email: 'contato@lg.com.br')
  
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
  
    # Assert
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Samsung Eletronicos LTDA'
    expect(page).to have_content 'São Paulo'
    expect(page).to have_content 'LG'
    expect(page).to have_content 'LG do Brasil LTDA'
    expect(page).to have_content 'Guarulhos'
  end
  
  it 'e não existem fornecedores cadastrados' do
    # Arrange
    user = User.create!(email: 'joao@email.com', password: 'password')
  
    # Act
    login_as(user)
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
  
    # Assert
    expect(page).to have_content 'Nenhum fornecedor cadastrado'
  end
end