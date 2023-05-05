require 'rails_helper'

describe 'Usuário vê modelos de produto' do
	it 'a partir do menu' do
		# Arrange

		# Act
		visit root_path
		within('nav') do
			click_on 'Modelos de Produtos'
		end

		# Assert
		expect(current_path).to eq product_models_path
	end
end