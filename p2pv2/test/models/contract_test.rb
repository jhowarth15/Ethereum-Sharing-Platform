require 'test_helper'

class ContractTest < ActiveSupport::TestCase

    def setup
	    @contract = Contract.new(created_at: "2016-05-23",
				     item_id: 321,
				     lender_id: "52", 
				     inquirer_id: "64",
				     key: "12",
				     loaned_out: "2016-05-25", 
				     returned: "2016-05-28",
				     deposit: 299.99, 
				     rental_rate: 21.95)
    end
	

	# Basic validity test.
	    test "should be valid" do
        assert @contract.valid?
    end

	# Can't have no creation date.
	test "created_at should be present" do
		@contract.created_at = ""
		assert_not @contract.valid?
	end

	# Must be associated to an item.
	test "item_id should be present" do
		@contract.item_id = ""
		assert_not @contract.valid?
	end

	# Must be associated to a lender.
	test "lender_id should be present" do
		@contract.lender_id = ""
		assert_not @contract.valid?
	end
	
	# Must be associated to an inquirer.
	test "inquirer_id should be present" do
		@contract.inquirer_id = ""
		assert_not @contract.valid?
	end

	# Must have a key.
	test "key should be present" do
		@contract.key = ""
		assert_not @contract.valid?
	end

end
