class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :city
      t.string :country
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
