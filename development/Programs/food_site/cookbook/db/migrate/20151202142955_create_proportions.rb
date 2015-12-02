class CreateProportions < ActiveRecord::Migration
  def change
    create_table :proportions do |t|
      t.integer :measurement_id
      t.integer :ingredient_id
      t.float :quantity
      t.integer :recipe_id

      t.timestamps null: false
    end
  end
end
