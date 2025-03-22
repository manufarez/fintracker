class Transaction < ApplicationRecord
  TRANSACTION_TYPES = %w[expense income]

  belongs_to :user
  belongs_to :category

  validates :amount, presence: true
  validates :transaction_type, presence: true, inclusion: {in: TRANSACTION_TYPES}
  validates :date, presence: true

  monetize :amount_cents

  scope :descending_by_date, -> { order(date: :desc) }
  scope :expense, -> { where(transaction_type: "expense") }
  scope :income, -> { where(transaction_type: "income") }

  before_save :ensure_amount_sign
  after_save :update_user_balance

  def self.daily_amounts(user)
    daily_totals = expense.group_by_day(:date).sum(:amount_cents)

    daily_totals.map do |date, amount|
      {
        x: date.to_time.to_i * 1000, # date is already a Date object
        y: amount.abs / 100.0
      }
    end.sort_by { |point| point[:x] }
  end

  def category_name
    category.name
  end

  private

  def ensure_amount_sign
    self.amount = -amount if transaction_type == "expense"
  end

  def update_user_balance
    user.update!(balance: user.balance + amount)
  end
end
