class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :properties , :tipo , :Type
  end
end
