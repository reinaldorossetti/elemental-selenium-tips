require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for :firefox
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

#run do
#  @driver.get 'http://the-internet.herokuapp.com/windows'
#  @driver.find_element(css: '.example a').click
#  @driver.switch_to.window(@driver.window_handles.first)
#  expect(@driver.title).not_to eql 'New Window'
#  @driver.switch_to.window(@driver.window_handles.last)
#  expect(@driver.title).to eql 'New Window'
#end

run do
  @driver.get 'http://the-internet.herokuapp.com/windows'

  first_window = @driver.window_handle
  @driver.find_element(css: '.example a').click
  all_windows = @driver.window_handles
  new_window = all_windows.select { |this_window| this_window != first_window }

  @driver.switch_to.window(first_window)
  expect(@driver.title).not_to eql 'New Window'
  @driver.switch_to.window(new_window)
  expect(@driver.title).to eql 'New Window'
end

def window_last(first_window)
  
  # go to the last window
  puts "first_window: %s" % first_window
  all_windows = @driver.window_handles
  puts  all_windows
  @driver.switch_to.window  all_windows[-1]

end

def window_first(current_window)
  
  # go to the first window
  puts "current_window: %s" % current_window
  all_windows = @driver.window_handles
  puts  all_windows
  @driver.switch_to.window  all_windows[0]

end

