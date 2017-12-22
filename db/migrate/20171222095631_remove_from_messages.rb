class RemoveFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :sender_id
    remove_column :messages, :reciever_id
  end
end
