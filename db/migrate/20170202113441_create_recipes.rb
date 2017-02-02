class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :body
      t.boolean :best_answer

      t.timestamps
    end
  end
end
