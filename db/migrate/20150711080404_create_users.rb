class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name,     null: false, :limit => 100  
      t.string :email,    null: false, :limit => 50
      t.string :password, null: false, :limit => 100
      t.string :phone,    null: false, :limit => 30
      t.string :api_key,  null: false 

      t.timestamps null: false
    end
  end
end
