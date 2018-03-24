class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :league_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
