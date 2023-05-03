# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
  address: 'Av Oceânica, 500', cep: '20000-000', description: 'Galpão no Rio')
Warehouse.create!(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
  address: 'Av da Praia, 800', cep: '56000-000', description: 'Galpão em Maceió')
Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA',
  registration_number: '07317108000151', full_address: 'Av Nacoes Unidas, 1000',
  city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')
Supplier.create!(brand_name: 'LG', corporate_name: 'LG do Brasil LTDA',
  registration_number: '34356508000149', full_address: 'Av Ibirapuera, 300',
  city: 'Guarulhos', state: 'SP', email: 'contato@lg.com.br')
