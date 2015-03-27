class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :chatroom_id
      t.string :user, null: false
      t.string :message, null: false

      t.timestamps null: false
    end

    add_index :messages, :chatroom_id
  end
end
