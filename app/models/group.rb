class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  has_many :events

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :profile_image


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
