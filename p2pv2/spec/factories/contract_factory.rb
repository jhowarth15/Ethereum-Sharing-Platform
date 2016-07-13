FactoryGirl.define  do
  factory :contract do
    created_at { Faker::Time.between(DateTime.now - 10, DateTime.now) }
    item_id 2
    lender_id 5
    inquirer_id 6
    key 'abdfeg'
  end
end