class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attr_accessible :email, :password, :password_confirmation


  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: "sender_id"
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: "receiver_id"

  has_many :pending_friend_requests, -> { where(status: 'pending') }, through: :received_friend_requests, source: :sender

  def send_friend_request(receiver)
    sent_friend_requests.create(receiver: receiver, status: 'pending')
  end

  def pending_friend_requests
    received_friend_requests.where(status: 'pending')
  end

  has_many :notifications
end

