namespace :dummy_data do

  desc "Generate some Users/Contacts/Debts for testing purposes"
  task generate: :environment do

    #TODO: reactivate this when the app will be in a real production env
  	#return if Rails.env.production?
    
  	#Before all deleta old data
  	puts "Deleting old data of User, Contact and Debt"
  	User.delete_all
  	Contact.delete_all
  	Debt.delete_all

  	nUsers = 5
  	nContacts = 10
  	nDebts = 5
  	#Create my own 
  	create_users(1,{name: "Abian",password: "12345678",email: "Abian@email.com",phone: "555-555-555"})
  	#Create 20 dummy users
  	create_users(nUsers)

  	#Create some contact and debts for each N Users.
  	User.all.limit(nUsers).each do |user|
  		create_contacts(nContacts, {user_id: user.id})
  		#Get first nContacts of the current user
  		contacts_ids = Contact.where(user_id: user.id).limit(nContacts).map{|u| u.id}
  		#Create some debts
  		create_debts(nDebts,{user_id: user.id}, contacts_ids)
  	end
  end


  #Auxilar methods
  def create_users(n, params={})
  	n.times do
	  		u = User.new(
	  			name: 		params[:name] 		|| Faker::Name.name,
	  			password: params[:password] || Faker::Internet.password,
	  			email: 		params[:email] 		|| Faker::Internet.email,
	  			phone: 		params[:phone] 		|| Faker::PhoneNumber.cell_phone
	  			)
	  	message = u.save ?  "Created user #{u.name}" : "Something was wrong with User:#{u.name} #{u.errors.messages}"
	  	puts message
  	end
  end

  def create_contacts(n, params={})
  	n.times do
	  		c = Contact.new(
	  			name: 		params[:name] 		|| Faker::Name.name,
	  			user_id:  params[:user_id],
	  			email: 		params[:email] 		|| Faker::Internet.email,
	  			phone: 		params[:phone] 		|| Faker::PhoneNumber.cell_phone
	  			)
	  	message = c.save ?  "Created Contact #{c.name} of #{params[:user_id]}" : "Something was wrong with Contact:#{c.name} #{c.errors.messages}"
	  	puts message
  	end
  end

  def create_debts(n, params={}, contacts_ids)
  	n.times do
	  		d = Debt.new(
	  			user_id: 				params[:user_id],
	  			contact_id:  		contacts_ids[ rand(contacts_ids.size + 1) ],
	  			quantity: 			params[:quantity]				|| Faker::Commerce.price,
	  			description: 		params[:description] 		|| Faker::Lorem.sentence,
	  			type_cd: 				params[:type_cd] 				|| rand(Debt.types.keys.count),
	  			status_cd: 			params[:status_cd] 			|| rand(Debt.statuses.keys.count),
	  			created_by_cd:  params[:created_by_cd] 	|| rand(Debt.created_bies.keys.count),
	  			)
	  	message = d.save ?  "Created Debt #{d.id} of #{params[:user_id]}" : "Something was wrong with Debt:#{d.id} #{d.errors.messages}"
	  	puts message
  	end
  end


end
