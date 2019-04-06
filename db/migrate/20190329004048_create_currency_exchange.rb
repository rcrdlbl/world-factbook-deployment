class CreateCurrencyExchange < ActiveRecord::Migration[5.2]
  def change
    create_table :currency_exchanges do |t|
      t.string :user_currency
      t.string :selected_currency
      t.float :result

      t.timestamps
    end
  end
end
