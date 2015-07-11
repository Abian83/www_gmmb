class User < ActiveRecord::Base
	has_many :mydebts,	class_name: "Debt", foreign_key: "from", :dependent => :delete_all
	has_many :debtors,	class_name: "Debt", foreign_key: "to",   :dependent => :delete_all
	
	#Email must be uniquess, it is not case-sentitive, not allowed foo@email.com and Foo@email.com
	validates_uniqueness_of :email, :case_sensitive => false
	#Required fields
	validates :name,:email,:password,:phone, presence: true

end
