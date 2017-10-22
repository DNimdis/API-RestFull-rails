class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.integer :type
      t.string :title
      t.string :address
      t.string :zicpcode
      t.string :country
      t.string :notes

      t.timestamps
    end
  end
end
