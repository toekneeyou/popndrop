class AddPhotoToToilets < ActiveRecord::Migration[5.2]
  def change
    add_column :toilets, :photo, :string
  end
end
