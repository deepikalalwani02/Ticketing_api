require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets-staging.paytm.com/banks"

describe "Get /banks" do
	it "should return 200 authorized" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 200
			list = JSON.parse(response)
			list.is_a? (Array)
			if true then 
				puts "Output is an array" 
			else 
				puts "Output is not an array"
			end
			list.length.should > 0
			puts "Available payment options are :"
			puts list
			credit_list	= list["credit_card"]
			credit_list.is_a? (Array)
			if true then 
				puts "Output of credit cards is an array" 
			else 
				puts "Output of credit cards is not an array"
			end
			credit_list.length.should > 0
			puts "Credit cards we allow are :"
			puts credit_list
			credit_list.should_not   == nil
			debit_list = list["debit_card"]
			debit_list.is_a? (Array)
			if true then 
				puts "Output of debit cards is an array" 
			else 
				puts "Output of debit cards is not an array"
			end
			debit_list.length.should > 0
			puts "We allow debit cards of follwoing banks :"
			puts debit_list
			debit_list.should_not 	 == nil
		end
	end

	it "Single id should not contain details of two banks" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 200
			list = JSON.parse(response)
			netbanking_list = list["net_banking"]
			netbanking_list.is_a? (Array)
			if true then 
				puts "Output of netbanking is an array" 
			else 
				puts "Output of netbanking is not an array"
			end
			netbanking_list.length.should > 0
			puts "We allow netbanking from following banks"
			puts netbanking_list
			netbanking_list.should_not  		  == nil
			netbanking_list.each do |type|
				type["id"].should_not 			  == nil
				type["name"].should_not			  == nil
				type["short_name"].should_not     == nil
				if  type["id"] 					  == 39
					type["name"].should 		  == "Royal Bank of Scotland"
					type["short_name"].should 	  == "royal_bank_of_scotland"
				end
				if  type["id"] 					  == 39
					type["name"].should_not 	  == "State Bank of Travancore"
					type["short_name"].should_not == "state_bank_of_travancore"
				end
			end
		end
	end
end