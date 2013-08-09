class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :league
      t.integer :rank

      t.timestamps
    end
  end
end
