class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url = users_activate_url + "?" + user.activation_token
  end

end
