class UserMailer < ApplicationMailer
  default from: 'notifications@candle.keep'

  def overdue_email
    @user = params[:user]
    @checkouts = params[:checkouts]
    mail(to: @user.email, subject: 'Overdue books at Candlekeep')
  end

  def notification_email
    @notification_request = params[:notification_request]
    mail(to: @notification_request.user.email,
         subject: 'Your book is back in the library!')
  end
end
