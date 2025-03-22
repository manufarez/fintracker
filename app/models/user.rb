class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :transactions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  monetize :balance_cents

  def avatar_url
    "https://github.com/#{username}.png"
  end

  def amount_spent_this_month
    range = Time.current.beginning_of_month..Time.current.end_of_month.end_of_day
    scope = transactions.where(transaction_type: "expense").where(date: range)
    Money.new(scope.sum(:amount_cents), balance_currency)
  end

  def amount_spent_last_week
    range = Time.current.beginning_of_week..Time.current.end_of_week.end_of_day
    scope = transactions.where(transaction_type: "expense").where(date: range)
    Money.new(scope.sum(:amount_cents), balance_currency)
  end

  def amount_spent_this_year
    transactions.where(date: Date.today.beginning_of_year..Date.today.end_of_year).sum(:amount_cents)
  end

  def last_weeks_income
    range = Time.current.beginning_of_week..Time.current.end_of_week.end_of_day
    scope = transactions.where(transaction_type: "income").where(date: range)
    Money.new(scope.sum(:amount_cents), balance_currency)
  end
end
