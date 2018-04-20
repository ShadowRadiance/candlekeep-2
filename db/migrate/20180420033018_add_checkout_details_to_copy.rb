class AddCheckoutDetailsToCopy < ActiveRecord::Migration[5.2]
  def change
    add_reference :copies, :checked_out_by, foreign_key: {to_table: :users}
    add_column :copies, :checked_out_at, :datetime
    add_column :copies, :due_at, :datetime
  end
end

