#encoding: UTF-8

require 'cucumber'
require 'rspec'
require 'selenium-webdriver'
require 'capybara'
require 'capybara/dsl'


Capybara.register_driver :selenium_chrome do |app|
    arguments = ["no-sandbox"]
    #arguments = ["headless","no-sandbox"]
    options = Selenium::WebDriver::Chrome::Options.new(args: arguments)
    # noinspection RubyArgCount
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.run_server = false
Capybara.default_driver = :selenium_chrome
Capybara.default_max_wait_time = 10

World(Capybara::DSL)