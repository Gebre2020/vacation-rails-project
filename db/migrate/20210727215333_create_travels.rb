class CreateTravels < ActiveRecord::Migration[6.1]
  def change
    create_table :travels do |t|
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end
