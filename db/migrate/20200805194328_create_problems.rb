class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :subject
      t.string :topic
      t.string :question
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
