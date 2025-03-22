class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, presence: true, uniqueness: {scope: :user_id}
  validates :description, presence: true
  validates :color_code, presence: true
end
