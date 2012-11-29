require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets.paytm.com/passengers"

describe "Get /passengers" do
	it "should return 400 unauthorized if user is not logged in" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 401
			puts response.inspect

		end
	end
	it "should return 200 authorized if user is logged in" do
		auth_url = "http://hub.paytm.com/user/authenticate" 
			response = RestClient.get(
				"http://tickets.paytm.com/passengers",
				{:cookies => {:paytm_token => "80e9f454bfe872968567b1352e417ee9"}}
				)
			details = JSON.parse(response)
			response.code.should == 200
            puts details
            details.each do |passenger_detail|
            	passenger_detail["id"].should_not 						== nil
            	passenger_detail["age"].should_not 						== nil
            	passenger_detail["title"].should_not 					== nil
            	passenger_detail["gender"].should_not 					== nil
            	passenger_detail["user_id"].should_not					== nil
            	# passenger_detail["mobile_number"].should_not 			== nil
            	# passenger_detail["email"].should_not 					== nil
            	# passenger_detail["address"].should_not 					== nil
            	# passenger_detail["card_type"].should_not 				== nil
            	# passenger_detail["card_no"].should_not 					== nil
            	passenger_detail["name"].should_not 					== nil
            	# passenger_detail["pass_detail_hash"].should_not 		== nil
            	passenger_detail["created_at"].should_not 				== nil
            	passenger_detail["updated_at"].should_not 				== nil
            end
   	end
end