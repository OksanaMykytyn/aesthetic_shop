class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :slug
      t.string :sku
      t.text :description
      t.integer :price_cents
      t.string :currency
      t.integer :stock
      t.references :category, null: false, foreign_key: true
      t.float :rating_avg
      t.boolean :active

      t.timestamps
    end
  end
end
