class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :number
      t.string :status
      t.integer :total_cents
      t.jsonb :shipping_address
      t.jsonb :billing_address
      t.string :payment_method
      t.string :shipping_method
      t.text :notes
      t.string :promo_code
      t.integer :promo_discount_cents

      t.timestamps
    end
  end
end
