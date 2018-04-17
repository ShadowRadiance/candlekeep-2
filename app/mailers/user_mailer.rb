class UserMailer < ApplicationMailer
  default from: 'notifications@candle.keep'

  def overdue_email
    @user = params[:user]
    @checkouts = params[:checkouts]
    mail(to: @user.email, subject: 'Overdue books at Candlekeep')
  end
end
