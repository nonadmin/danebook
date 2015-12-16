FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "fooBAR01" }
  end
  
  
  factory :profile do
    sequence(:first_name) { |n| "foo#{n}"}
    last_name { "bar" }
    birthday { 30.years.ago }
  end


  factory :post do
    author
    body { "a" * 13 }
  end


  factory :comment do
    author
    association :commentable, factory: :post
    body { "a" * 13 }
  end


  factory :like do
    association :creator, factory: :user
    association :likeable, factory: :post
  end

end 