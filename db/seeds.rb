# Пользователи
User.create!(name: "Example User", #создает пользователя
			 email: "example@railstutorial.org",
			 password: "foobar",
			 password_confirmation: "foobar",
			 admin: true,
			 activated: true,
			 activated_at: Time.zone.now)
			
99.times do |n| 
  name = Faker::Name.name #присваетвает значение имени
  email = "example-#{n+1}@railstutorial.org" #ставив в конце цифру для индивидальной почты
  password = "password" 
  User.create!(name: name, #создает пользователя
			   email: email,
			   password: password,
			   password_confirmation: password,
			   activated: true,
			   activated_at: Time.zone.now)
end

# Микросообщения
users = User.order(:created_at).take(6) #возьми по порядку первых 6 пользователей
50.times do
	content = Faker::Lorem.sentence(word_count: 5)	
	users.each { |user| user.microposts.create!(content: content) } #и создай для каждого польозвателя посты по 50 штук
end

# Взаимоотношения следования

users = User.all  
user = users.first
following = users[2..50] #читающих 
followers = users[3..40] #подписчиков
following.each { |followed| user.follow(followed) } #пользователь подписывается на читаемых
followers.each { |follower| follower.follow(user) } #пользователь имеет подписчиков (подпсчика подписаны на пользователя)