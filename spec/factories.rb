FactoryGirl.define do

  factory :user, aliases: [:author] do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "fooBAR01" }
  end
  
end 