class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true #добавить индекс в таблицу пользователи, атрибут электронная почта, уникальность 
  end
end
