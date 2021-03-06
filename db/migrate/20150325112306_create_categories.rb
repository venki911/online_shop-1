class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :ancestry, default: nil
      t.timestamps null: false
    end
    add_index :categories, :ancestry
  end
end
