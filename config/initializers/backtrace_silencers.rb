# Be sure to restart your server when you modify this file.

# You can add backtrace silencers for libraries that you're using but don't wish to see in your backtraces.
# Rails.backtrace_cleaner.add_silencer { |line| line =~ /my_noisy_library/ }

# You can also remove all the silencers if you're trying to debug a problem that might stem from framework code.
# Rails.backtrace_cleaner.remove_silencers!

# Перезапустите сервер после изменения этого файла
# Вы можете добавить глушитель для библиотек, которыми пользуетесь, но не хотите видеть
# в трассировке
Rails.backtrace_cleaner.add_silencer { |line| line =~ /rvm/ }
# Также можно удалить все глушители, если проблема происходит из кода фреймворка
# Rails.backtrace_cleaner.remove_silencers!