class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_foreign_key :microposts, :users
    add_index :microposts, [:user_id, :created_at] #для обратного порядка
  end
end
