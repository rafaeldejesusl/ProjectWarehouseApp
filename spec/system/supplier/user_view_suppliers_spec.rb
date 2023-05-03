require 'rails_helper'

describe 'Usuário vê fornecedores' do
	it 'a partir do menu' do
		# Arrange

		# Act
		visit root_path
		within('nav') do
			click_on 'Fornecedores'
		end

		# Assert
		expect(current_path).to eq suppliers_path
	end
end