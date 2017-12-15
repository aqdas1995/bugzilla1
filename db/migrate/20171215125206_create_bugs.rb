class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.date :deadline
      t.string :type
      t.string :status

      t.timestamps
    end
  end
end
