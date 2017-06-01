class MyPoll < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :expires_at, presence: true

  validates :user, presence: true

  def is_valid?
    DateTime.now < self.expires_at
  end

  MyPoll.create(user_id: 1)
end
