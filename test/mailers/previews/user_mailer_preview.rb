# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def overdue_email
    UserMailer.with(user: User.first,
                    checkouts: Checkout.take(5)).overdue_email
  end
end
