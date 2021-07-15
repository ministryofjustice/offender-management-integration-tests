# frozen_string_literal: true

require 'bundler/setup'
Bundler.setup(:default, :development)
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

Dir['./spec/support/**/*.rb'].each { |f| require f }

Capybara.default_driver = :selenium
Capybara.save_path = File.expand_path('../screenshots', __dir__)

# Wait (up to) a really long time for pages to load – useful for when the Prison API is being slow
Capybara.default_max_wait_time = 30

RSpec.configure do |config|
  config.include Helpers::Authentication, type: :feature
  config.include Helpers::Breadcrumbs, type: :feature

  config.disable_monkey_patching!
  config.before(:all) do
    page.driver.browser.manage.window.resize_to(1920, 1080)
  end
end
