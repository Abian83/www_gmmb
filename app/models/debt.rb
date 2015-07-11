class Debt < ActiveRecord::Base
	belongs_to :from_user,	class_name: "User", foreign_key: "from"
	belongs_to :to_user,		class_name: "User", foreign_key: "to"

	validates :from,:to,:quantity,:description, presence: true
	validate :users_exit?

	#The users "from" and "to" must exist to create a debt.
	#TODO: we have to check that both users are in the same contact lists!!
	def users_exit?
		begin
			User.find(self.to) && User.find(self.to)	
		rescue Exception => e
			self.errors.add(:users , "Incorrect ids of FROM and TO")
			false
		end
	end

end
