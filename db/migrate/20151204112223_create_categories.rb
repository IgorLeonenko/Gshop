class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.text :short_description
      t.text :description
      t.integer :number

      t.timestamps null: false
    end
  end
end
