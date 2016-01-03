# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
ActionMailer::Base.perform_deliveries = false

MULTIPLIER = 10

def rand_date(year_from, year_to)
  from = (year_from.years.ago) 
  to = (year_to.years.ago)
  Time.at(rand(from..to))
end

def rand_location
  "#{Faker::Address.city}, #{Faker::Address.state}"
end

def create_user(email = nil)
  u = User.new
  u.email = email.nil? ? Faker::Internet.email : email
  u.password = "fooBAR01"

  p = Profile.new
  p.birthday = rand_date(50, 13)
  p.gender = ["male", "female", ""].sample
  p.first_name = Faker::Name.first_name
  p.last_name = Faker::Name.last_name
  p.about = Faker::Hipster.paragraph(4)
  p.quote = Faker::Hipster.sentence
  p.college = Faker::University.name
  p.hometown = rand_location
  p.current_location = [p.hometown, rand_location].sample
  p.phone = Faker::PhoneNumber.phone_number

  u.profile = p
  u.save!
end

# create some users that will get a lot of comments and likes
create_user("justin.mullis@gmail.com")
create_user("justin@nightiron.com")
po = User.first.posts.new(body: Faker::Hipster.paragraph(4))
po.save!
co = Post.first.comments.new(author: User.first, body:Faker::Hipster.paragraph)
co.save!

# create some more generic users
(MULTIPLIER*4).times do |num|
  create_user
end

users = User.all
(MULTIPLIER**2).times do |num|
  u = users.sample
  p = u.posts.new(body: Faker::Hipster.paragraph(4))
  p.save!
  p.created_at = rand_date(3,1)
  p.save!
end

photos = [
  File.new("#{Rails.root}/app/assets/images/cylon.jpg"),
  File.new("#{Rails.root}/app/assets/images/derp.jpg"),
  File.new("#{Rails.root}/app/assets/images/dixie.jpg"),
  File.new("#{Rails.root}/app/assets/images/hardac.jpg"),
  File.new("#{Rails.root}/app/assets/images/leah.jpg")
]
users.sample(5).each do |user|
  p = user.photos.new(image: photos.pop)
  p.save!
  user.profile.profile_photo = p
  user.save!
  User.first.friends << user
end

posts = Post.all
((MULTIPLIER+5)**2).times do |num|
  u = users.sample
  p = posts.sample
  c = p.comments.new(author: u, body: Faker::Hipster.paragraph)
  c.save!
end

users.each do |user|
  posts = Post.all.to_a
  l = posts.pop.likes.new(creator: user)
  l.save!
  posts.shuffle!
  (MULTIPLIER).times do |num|
    l = posts.pop.likes.new(creator: user)
    l.save!
  end
  comments = Comment.all.to_a.shuffle
  (MULTIPLIER).times do |num|
    l = comments.pop.likes.new(creator: user)
    l.save!
  end  
end