class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.text :title
      t.text :content
      t.string :tag
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
