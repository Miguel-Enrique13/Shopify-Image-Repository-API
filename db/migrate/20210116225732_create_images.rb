class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :description, default: '---'
      t.string :title, default: '---'
      t.string :privacy, default: 'privacy'
      t.float :price, default: 0.0
      t.integer :inventory, default: 0

      t.timestamps
    end
  end
end
