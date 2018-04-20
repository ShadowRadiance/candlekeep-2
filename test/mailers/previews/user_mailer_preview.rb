# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def overdue_email
    UserMailer.with(user: User.first,
                    checkouts: Checkout.take(5)).overdue_email
  end

  def notification_email
    notification = NotificationRequest.new(user: User.first,
                                           book: Book.first)
    UserMailer.with(notification_request: notification).notification_email
  end
end
