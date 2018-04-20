namespace :migrate_data do
  desc 'One Time Data Migration'
  task add_checkout_details_to_copy: :environment do

    checkouts = Checkout.includes(:copy).active

    puts "Moving #{checkouts.count} active checkouts to the related copy"

    ActiveRecord::Base.transaction do
      checkouts.each do |checkout|
        checkout.copy.update!(
          checked_out_by: checkout.user,
          checked_out_at: checkout.checked_out_at,
          due_at: checkout.due_at)
        print '.'
      end
    end

    puts ' All done!'
  end
end
