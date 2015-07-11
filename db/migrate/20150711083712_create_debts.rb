class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.integer :from,				null:false
      t.integer :to, 					null:false
      t.float 	:quantity,		null:false
      t.string 	:description,	null:false

      t.timestamps null: false
    end
  end
end
