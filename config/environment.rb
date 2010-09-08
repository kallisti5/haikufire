# Load the rails application
require File.expand_path('../application', __FILE__)

# correct stupid rails error div to a span
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|"<span class=\"fieldWithErrors\">#{html_tag}</span>" }

# TODO:DEPLOY
# consumer_token is consumer_key
# consumer_secret is consumer_secret
Twitter::Client.configure do |conf| 
  conf.oauth_consumer_token = "XXX"
  conf.oauth_consumer_secret = "XXX"
end 

# Initialize the rails application
Haikufire::Application.initialize!
