class UserMailer < ActionMailer::Base
  default from: "Candace <candace.schenk@gmail.com>"

  def welcome_email(user)
    @user = user
    @url = users_activate_url(activation_token: user.activation_token)
    mail(to: user.email, subject: 'Welcome!')
  end

end
