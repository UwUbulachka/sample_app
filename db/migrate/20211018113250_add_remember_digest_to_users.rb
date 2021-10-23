class AddRememberDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_digest, :string #добовление столбца в таблицу пользователи, столбец remember_digest с типом строка
  end
end
