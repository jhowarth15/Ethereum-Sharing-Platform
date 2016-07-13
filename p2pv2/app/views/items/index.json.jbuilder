json.array!(@items) do |item|
  json.extract! item, :id, :name, :category, :model, :age, :location, :min_loan_period, :max_loan_period, :deposit, :rental_rate
  json.url item_url(item, format: :json)
end
