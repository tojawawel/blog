class UserMailer < ApplicationMailer
  default from: 'dontreply@jajo.com'

  def liked_article(user)
    @user = user
    mail(to: @user.email, subject: 'Liked article')
  end
end
