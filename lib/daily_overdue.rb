class DailyOverdue
  attr_reader :io
  def initialize(io=nil)
    @io = io
  end
  
  def run
    overdue_checkouts = Checkout.overdue(Time.current)

    overdue_checkouts_by_user = {}
    overdue_checkouts.each do |checkout|
      overdue_checkouts_by_user[checkout.user.email] ||= {
        user: checkout.user,
        checkouts: []
      }
      overdue_checkouts_by_user[checkout.user.email][:checkouts] << checkout
    end

    failed = 0
    overdue_checkouts_by_user.each do |email, hsh|
      begin
        io.puts "Sending email to #{email}..."
        UserMailer.with(hsh).overdue_email.deliver_now!
        io.puts 'Sent successfully'
      rescue StandardError => e
        io.puts "Send failed: #{e.message}"
        failed += 1
      end
    end

    [overdue_checkouts_by_user.count - failed, failed]
  end

end