class AddProjectIdToBugs < ActiveRecord::Migration[5.1]
  def change
    add_reference :bugs, :project, foreign_key: true
  end
end
