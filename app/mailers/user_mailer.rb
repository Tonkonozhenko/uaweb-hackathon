class UserMailer < ActionMailer::Base
  default from: 'from@example.com'

  def one_click_email(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
