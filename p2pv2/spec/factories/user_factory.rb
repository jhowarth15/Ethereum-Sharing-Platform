FactoryGirl.define  do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    name_first 'first'
    name_last 'last'
    password { Faker::Internet.password }
  end
end