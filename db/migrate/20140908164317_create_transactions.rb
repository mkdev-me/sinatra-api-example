class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :description
      t.integer :amount
      t.date :date
    end
  end
end
