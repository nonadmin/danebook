FactoryGirl.define do  
  
  factory :user, aliases: [:author] do
    sequence(:email) { |n| "foo#{n}@example.com" }
    password { "fooBAR01" }
    profile

    factory :user_with_posts do
      transient do
        posts_count 5
      end

      after(:create) do |user, eval|
        create_list(:post, eval.posts.count, author: user)
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