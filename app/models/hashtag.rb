class Hashtag < ApplicationRecord
  has_many :book_hashes
  has_many :books, through: :book_hashes
end
