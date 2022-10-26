class CreateBookHashes < ActiveRecord::Migration[6.1]
  def change
    create_table :book_hashes do |t|
      t.integer :book_id
      t.integer :hashtag_id

      t.timestamps
    end
  end
end
