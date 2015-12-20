class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :last_name
      t.text :address
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
