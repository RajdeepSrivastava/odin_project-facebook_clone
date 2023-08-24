class Notification < ApplicationRecord
  belongs_to :user

  scope :unread, -> { where(read_status: false) }
end