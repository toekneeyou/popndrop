class AddCoordinatesToToilets < ActiveRecord::Migration[5.2]
  def change
    add_column :toilets, :latitude, :float
    add_column :toilets, :longitude, :float
  end
end
