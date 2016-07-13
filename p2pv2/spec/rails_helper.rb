if ARGV.include?('~coverage')
  require 'simplecov'
  SimpleCov.start 'rails'
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'devise'
require 'capybara/rspec'
# Add additional requires below this line. Rails is not loaded until this point!


Rails.application.eager_load! if ARGV.include?('~coverage')

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  config.render_views = true

  config.order = 'random'
  config.include Capybara::DSL

  # Use FactoryGirl
  config.include FactoryGirl::Syntax::Methods

  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, :type => :controller
  config.include Warden::Test::Helpers
  config.include ActiveSupport::Testing::TimeHelpers

  # config.include ApplicationHelper

  Warden.test_mode!
  config.after(:each) do
    Warden.test_reset!
  end

  config.before(:each) do
    Rails.cache.clear
  end

  # use the before hook to add an after hook that runs last
  config.after do |example_from_block_arg|
    # RSpec 3 no longer defines `example`, but passes the example as block argument instead
    example = config.respond_to?(:expose_current_running_example_as) ? example_from_block_arg : self.example

    if Capybara.page.respond_to?(:save_page) # Capybara DSL method has been included for a feature we can snapshot
      if Capybara.page.driver.respond_to?(:render) && Capybara.page.current_url != '' && example.exception && ENV['CIRCLECI']
        take_screenshot(file: "screenshot_on_failure_#{Time.now.to_i}.png")
      end
    end
  end

  config.after(:suite) do
    if Rails.env.test?
      # Clean all uploads created by factories
      puts "\nCleaning #{Rails.root}/public/uploads/test/"
      FileUtils.rm_rf(Dir["#{Rails.root}/public/uploads/test/[^.]*"])
    end
  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end

FactoryGirl.reload
