# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup(:default, :development)
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Dir["./spec/support/**/*.rb"].each {|f| require f}

Capybara.default_driver = :selenium
Capybara.save_path = File.expand_path('../screenshots', __dir__)
Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.include Helpers::Authentication, type: :feature

  config.disable_monkey_patching!
  config.before(:all) do
    page.driver.browser.manage.window.resize_to(1920, 1080)
  end
end
