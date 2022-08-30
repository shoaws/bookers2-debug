class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.integer :user_id
      t.string :room_id
      t.string :integer
      t.string :message

      t.timestamps
    end
  end
end
