require Rails.root.join('spec/support/features/helpers.rb')

# spec/support/features.rb
RSpec.configure do |config|
  config.include Features::Helpers, type: :feature
  config.include Features::Helpers, type: :request
  config.include Features::Helpers, type: :production
end