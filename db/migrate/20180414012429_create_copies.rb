class CreateCopies < ActiveRecord::Migration[5.2]
  def change
    create_table :copies do |t|
      t.belongs_to :book, foreign_key: true
      t.datetime :destroyed_at

      t.timestamps
    end
  end
end
