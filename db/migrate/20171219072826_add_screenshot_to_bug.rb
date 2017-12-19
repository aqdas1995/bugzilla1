class AddScreenshotToBug < ActiveRecord::Migration[5.1]
  def change
    add_column :bugs, :image, :string
  end
end
