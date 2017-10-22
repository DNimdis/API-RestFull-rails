class CambioColumnaTipo < ActiveRecord::Migration[5.0]
  def change
      rename_column :properties , :type , :tipo
  end
end
