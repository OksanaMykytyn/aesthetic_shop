class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :label
      t.string :recipient_name
      t.string :phone
      t.string :country
      t.string :city
      t.string :postal_code
      t.string :street
      t.string :delivery_type
      t.string :branch_number
      t.boolean :is_default

      t.timestamps
    end
  end
end
