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
