class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :division_id
      t.integer :user_id
      t.integer :points, :null => false, :default => 50

      t.timestamps
    end
  end
end
