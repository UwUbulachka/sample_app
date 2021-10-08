class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t| #создание таблицы users
      t.string :name #столбец name с типом string
      t.string :email #столбец email с типом string

      t.timestamps #отметки времени автоматически записываются в момент создания и обновления записи
    end
  end
end
