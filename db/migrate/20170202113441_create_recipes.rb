class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :body
      t.boolean :best_answer
# set bool to default false
      t.timestamps
    end
  end
end
