class Contract < ActiveRecord::Base

	#has_many :users
	# Validations for presence in test/models/contract_test.rb

	validates :item_id,	 presence: true
	validates :lender_id,	 presence: true
	validates :inquirer_id,	 presence: true
	validates :key,		 presence: true
end
