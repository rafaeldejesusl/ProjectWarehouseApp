class Warehouse < ApplicationRecord
  validates :name, :code, :description, :city, :address, :cep, :area, presence: true
end
