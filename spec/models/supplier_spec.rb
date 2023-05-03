require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
		it 'falso quando o nome fantasia é vazio' do
			# Arrange
			supplier = Supplier.new(brand_name: '', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a razão social é vazia' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: '',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o CNPJ é vazio' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o endereço é vazio' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: '',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a cidade é vazia' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: '', state: 'SP', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o estado é vazio' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: '', email: 'sac@samsung.com.br')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o e-mail é vazio' do
			# Arrange
			supplier = Supplier.new(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: '')

			# Act
			result = supplier.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o CNPJ for repetido' do
      # Arrange
      first_supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '7317108000151', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
      second_supplier = Supplier.new(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
        registration_number: '7317108000151', full_address: 'Av Ibirapuera, 300',
        city: 'Guarulhos', state: 'SP', email: 'contato@lg.com.br')
    
      # Act
      result = second_supplier.valid?
    
      # Assert
      expect(result).to eq false
    end

    it 'falso quando o CNPJ não tiver 13 digitos' do
      # Arrange
      second_supplier = Supplier.new(brand_name: '', corporate_name: 'Samsung Eletronicos LTDA',
        registration_number: '731710800015', full_address: 'Av Nacoes Unidas, 1000',
        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
    
      # Act
      result = second_supplier.valid?
    
      # Assert
      expect(result).to eq false
    end
	end
end
