require 'daily_overdue'

namespace :candlekeep do
  desc 'Emails users with overdue books'
  task email_deadbeats: :environment do
    puts 'Emailing deadbeats...'
    counts = DailyOverdue.new($stdout).run
    puts "Emailed #{counts[0]} users. Failed to send to #{counts[1]} users."
    puts '...done'
  end

end
