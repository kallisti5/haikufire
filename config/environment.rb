# Load the rails application
require File.expand_path('../application', __FILE__)

# correct stupid rails error div to a span
ActionView::Base.field_error_proc = Proc.new { |html_tag, instance|"<span class=\"fieldWithErrors\">#{html_tag}</span>" }

# Initialize the rails application
Haikufire::Application.initialize!
