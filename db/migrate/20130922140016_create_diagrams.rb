class CreateDiagrams < ActiveRecord::Migration
  def change
    create_table :diagrams do |t|
      t.integer :question_id
      t.attachment :image
    end
  end
end
