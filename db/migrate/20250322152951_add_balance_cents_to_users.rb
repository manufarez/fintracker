class AddBalanceCentsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :balance_cents, :integer, default: 0
    add_column :users, :balance_currency, :string
  end
end
