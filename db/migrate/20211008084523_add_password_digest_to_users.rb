class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :password_digest, :string #добовление столбца в таблицу пользователи, столбец password_digest с типом строка
  end 
end
