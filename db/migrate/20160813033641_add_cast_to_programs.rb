class AddCastToPrograms < ActiveRecord::Migration[5.0]
  def change
    add_column :programs, :cast, :string
  end
end
