class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.string :description
      t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
