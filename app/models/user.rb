class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attr_accessible :email, :password, :password_confirmation
  attr_accessor :agree_terms


  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: "sender_id"
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: "receiver_id"

  has_many :pending_friend_requests, -> { where(status: 'pending') }, through: :received_friend_requests, source: :sender

  def send_friend_request(receiver)
    sent_friend_requests.create(receiver: receiver, status: 'pending')
  end

  def user_pending_requests
    received_friend_requests.where(status: 'pending')
  end

  has_many :friendships, foreign_key: "sender_id"
  has_many :friends, through: :friendships, source: :receiver
  has_many :notifications
  has_many :posts
  has_many :likes
  
  has_one_attached :profile_photo

  
  def like?(post)
    likes.exists?(post: post)
  end

  def pending_friendships
    received_friend_requests.where(status: 'pending')
  end

  def timeline_posts
    friend_ids = friendships.where(status: 'accepted').pluck(:receiver_id)
    Post.where(user_id: [id] + friend_ids)
  end

end

