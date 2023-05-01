require 'rails_helper'

describe 'Usuário edita um galpão' do
	it 'a partir da página de detalhes' do
		# Arrange
		w = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais'
		)

		# Act
		visit root_path
		click_on 'Aeroporto SP'
		click_on 'Editar'

		# Assert
		expect(page).to have_content 'Editar Galpão'
		expect(page).to have_field('Nome', with: 'Aeroporto SP')
		expect(page).to have_field('Descrição', with: 'Galpão destinado para cargas internacionais')
		expect(page).to have_field('Código', with: 'GRU')
		expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 1000')
		expect(page).to have_field('Cidade', with: 'Guarulhos')
		expect(page).to have_field('CEP', with: '15000-000')
		expect(page).to have_field('Área', with: '100000')
	end

end