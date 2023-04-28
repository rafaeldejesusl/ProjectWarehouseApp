require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
		it 'falso quando o nome é vazio' do
			# Arrange
			warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço',
				cep: '25000-000', city: 'Rio', area: 1000,
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o código é vazio' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: '', address: 'Endereço',
				cep: '25000-000', city: 'Rio', area: 1000,
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o endereço é vazio' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: '',
				cep: '25000-000', city: 'Rio', area: 1000,
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o CEP é vazio' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
				cep: '', city: 'Rio', area: 1000,
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a cidade é vazia' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
				cep: '25000-000', city: '', area: 1000,
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a área é vazia' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
				cep: '25000-000', city: 'Rio', area: '',
				description: 'Alguma descrição')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando a descrição é vazia' do
			# Arrange
			warehouse = Warehouse.new(name: 'Rio de Janeiro', code: 'RIO', address: 'Endereço',
				cep: '25000-000', city: 'Rio', area: 1000,
				description: '')

			# Act
			result = warehouse.valid?

			# Assert
			expect(result).to eq false
		end

    it 'falso quando o código for repetido' do
      # Arrange
      first_warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço',
        cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida',
        cep: '35000-000', city: 'Niteroi', area: 1500, description: 'Outra descrição')
    
      # Act
      result = second_warehouse.valid?
    
      # Assert
      expect(result).to eq false
    end

    it 'falso quando o CEP estiver com formato inválido' do
      # Arrange
      second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address: 'Avenida',
        cep: '35000-0000', city: 'Niteroi', area: 1500, description: 'Outra descrição')
    
      # Act
      result = second_warehouse.valid?
    
      # Assert
      expect(result).to eq false
    end
	end
end
