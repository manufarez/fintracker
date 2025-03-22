class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :transaction_type
      t.integer :amount_cents
      t.string :amount_currency
      t.datetime :date
      t.text :notes

      t.timestamps
    end
  end
end
