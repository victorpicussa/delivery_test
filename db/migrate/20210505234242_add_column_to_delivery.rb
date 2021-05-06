class AddColumnToDelivery < ActiveRecord::Migration[6.0]
  def change
    add_column :deliveries, :customer, :jsonb
    add_column :deliveries, :items, :jsonb
    add_column :deliveries, :payments, :jsonb
  end
end
