class User < ActiveRecord::Base
	has_many :mydebts,	class_name: "Debt", foreign_key: "from", :dependent => :delete_all
	has_many :debtors,	class_name: "Debt", foreign_key: "to",   :dependent => :delete_all
end
