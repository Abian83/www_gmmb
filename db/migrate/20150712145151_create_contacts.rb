class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id,	null:false
      t.string  :name,		null:false, :limit => 100
      t.string  :phone, 	:limit => 30
      t.string  :email, 	:limit => 100

      t.timestamps null: false
    end
  end
end
