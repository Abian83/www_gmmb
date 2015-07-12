class Contact < ActiveRecord::Base
	belongs_to :user
	validates :name, :email, :phone, presence: true
end
