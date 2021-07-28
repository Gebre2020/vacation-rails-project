class CreateTrips < ActiveRecord::Migration[6.1]
  def change
    create_table :trips do |t|
      t.belongs_to :location, null: false, foreign_key: true
      t.belongs_to :travel, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
