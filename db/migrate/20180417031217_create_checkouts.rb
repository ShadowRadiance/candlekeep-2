class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|

      t.belongs_to :user
      t.belongs_to :copy

      t.datetime :checked_out_at
      t.datetime :due_at
      t.datetime :checked_in_at

      t.timestamps
    end
  end
end
