class CreateToilets < ActiveRecord::Migration[5.2]
  def change
    create_table :toilets do |t|
      t.string :name
      t.string :address
      t.integer :rate
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
