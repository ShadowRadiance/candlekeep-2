class CreateNotificationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :notification_requests do |t|
      t.references :book, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :notification_requests, [:book_id, :user_id], unique: true
  end
end
