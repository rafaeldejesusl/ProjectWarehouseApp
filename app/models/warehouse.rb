class Warehouse < ApplicationRecord
  validates :name, :code, :description, :city, :address, :cep, :area, presence: true
  validates :code, uniqueness: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: "Deve estar no formato 00000-000" }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
