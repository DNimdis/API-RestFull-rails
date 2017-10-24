class ChangeColumTipo < ActiveRecord::Migration[5.0]
  def change
    rename_column :properties , :Type , :tipo
  end
end
