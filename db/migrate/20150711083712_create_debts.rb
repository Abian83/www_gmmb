class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.integer :user_id,			  null:false
      t.integer :contact_id, 	  null:false
      t.float 	:quantity,      null:false
      t.string 	:description,	  null:false, :limit => 200
      t.integer :type_cd,			  null:false
      t.integer :status_cd,		  null:false
      t.integer :created_by_cd, null:false    

      t.timestamps null: false
    end
  end
end

#Debt:1 user_id:1 contact_id:1 type:'debo|me deben' quantity:5 description:'Bocadillo que me compré' 
#state:sincronized|pending created_by:web|mobile