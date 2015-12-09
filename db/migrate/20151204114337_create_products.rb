class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string     :title
      t.string     :article
      t.string     :short_description
      t.text       :description
      t.string     :image
      t.belongs_to :category, index: true, foreign_key: true
      t.decimal    :price

      t.timestamps null: false
    end
  end
end
