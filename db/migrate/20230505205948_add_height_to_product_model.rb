class AddHeightToProductModel < ActiveRecord::Migration[7.0]
  def change
    add_column :product_models, :height, :integer
  end
end
