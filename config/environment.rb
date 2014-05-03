# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Unraveled::Application.initialize!

if Rails.env.production?
  # only send real emails in production; use Sengrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method ||= :smtp
  config.action_mailer.default_url_options = { host: 'polar-chamber-4664.herokuapp.com' }
elsif Rails.env.development?
  # Remember the letter_opener gem? It won't send real emails; it
  # just opens them in another tab.
  ActionMailer::Base.delivery_method = :letter_opener
  
end