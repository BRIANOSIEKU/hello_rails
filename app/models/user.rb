class User < ApplicationRecord
has_many :facts, dependent: :destroy
  # has_many :user_fact_likes, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true

  before_validation :ensure_token

  private

  def ensure_token
    self.token ||= SecureRandom.hex(16)
  end
end

