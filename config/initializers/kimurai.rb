require 'selenium-webdriver'
# Set Kimurai logger level to DEBUG (default is INFO)
Kimurai.configure do |config|
  config.logger = Logger.new(STDOUT)
  config.logger.level = Logger::DEBUG
end

# Use Selenium webdriver with headless option for rendering JavaScript
# This is optional, and you can use other drivers like capybara-webkit or poltergeist

Kimurai.configure do |config|
  config.driver_options = {
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]),
    driver_path: '/path/to/chromedriver'
  }
end