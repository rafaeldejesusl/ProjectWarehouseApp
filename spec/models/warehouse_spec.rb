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
			# Assert
			expect(result).to eq false
		end
	end
end
