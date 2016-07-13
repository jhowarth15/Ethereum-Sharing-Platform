FactoryGirl.define  do
  factory :item do
    name 'name'
    category 'category'
    model 'model1'
    age 1.5
    location 'location'
    min_loan_period 3.0
    max_loan_period 30.0
    deposit 50.0
    rental_rate 5.3
    association :user
  end
end