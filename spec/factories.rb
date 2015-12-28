FactoryGirl.define do

  sequence :email do |n|
    "foo#{n}@example.com"
  end  
  
  factory :user, aliases: [:author] do
    email
    password { "fooBAR01" }
    profile

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, eval|
        create_list(:post, eval.posts_count, author: user)
      end
    end


    factory :user_with_friends do
      transient do
        friends_count 6
      end

      after(:create) do |user, eval|
        create_list(:friending, eval.friends_count, friend_initiator: user)
      end
    end
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


  factory :friending do
    association :friend_initiator, factory: :user
    association :friend_receiver, factory: :user
  end

end 