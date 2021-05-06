class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :externalCode
      t.integer :storeId
      t.string :subTotal
      t.string :deliveryFee
      t.float :total_shipping
      t.string :total
      t.string :country
      t.string :state
      t.string :city
      t.string :district
      t.string :street
      t.string :complement
      t.float :latitude
      t.float :longitude
      t.string :dtOrderCreate
      t.string :postalCode
      t.string :number

      t.timestamps
    end
  end
end
