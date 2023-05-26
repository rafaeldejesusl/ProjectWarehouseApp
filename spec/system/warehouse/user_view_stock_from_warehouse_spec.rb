require 'rails_helper'

describe 'Usuário vê o estoque' do
	it 'na tela do galpão' do
		# Arrange
		supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
		registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
		city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
		produto_a = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10,
			sku: 'TV32-SAMSU-XPTO90', supplier: supplier)
		produto_b = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15,
		 depth: 20, sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
		produto_c = ProductModel.create!(name: 'Notebook i5', weight: 2000, width: 40, height: 9,
		 depth: 20, sku: 'NOTEI5-SAMSU-TLI99', supplier: supplier)
		user = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
		warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos',
			area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
			description: 'Galpão destinado para cargas internacionais')
		order = Order.create!(user: user, warehouse: warehouse, supplier: supplier,
			estimated_delivery_date: 1.day.from_now, status: :pending)
		3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: produto_a) }
		2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: produto_c) }
		
		# Act
		login_as user
		visit root_path
		click_on 'Aeroporto SP'

		# Assert
		within('section#stock_products') do
			expect(page).to have_content 'Itens em Estoque'
			expect(page).to have_content '3 x TV32-SAMSU-XPTO90'
			expect(page).to have_content '2 x NOTEI5-SAMSU-TLI99'
			expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
		end
	end
end