class Debt < ActiveRecord::Base
	belongs_to :from_user,	class_name: "User", foreign_key: "from"
	belongs_to :to_user,		class_name: "User", foreign_key: "to"
end
