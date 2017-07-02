class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :ticket_type_id
      t.string :code

      t.timestamps
    end
  end
end
