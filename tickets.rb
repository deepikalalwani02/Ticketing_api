require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'
require 'oauth2'

url = "http://tickets-staging.paytm.com/tickets"

describe "Get /tickets/" do

	it "should return 400 unauthorized" do
		RestClient.get(url) do |response, request, result, &block|
			puts response
			response.code.should == 401
		end
	end

	it "should return 200 authorized" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
		puts response
		response.code.should == 200
		response.length.should >0
		tickets_array = JSON.parse(response)
		tickets_array.is_a? (Array)
			if true then 
				puts "Output is an array" 
			else 
				puts "Output is not an array"
			end
			tickets_array.each do |tickets|
				tickets["block_key"].should_not 								== nil
				tickets["created_at"].should_not 								== nil
				tickets["destination_city_id"].should_not 						== nil
				# tickets["fare"].should_not 									== nil
				tickets["id"].should_not 										== nil
				tickets["is_feedback_sms_send"].should_not 						== nil
				tickets["passenger_count"].should_not 							== nil
				tickets["provider_id"].should 									== 1
				tickets["source_city_id"].should_not 							== nil
				tickets["status"].should_not 									== nil
				tickets["transaction_id"].should_not 							== nil
				tickets["travel_date"].should_not 								== nil
				# tickets["trip_id"].should_not 								== nil
				tickets["updated_at"].should_not 								== nil
				tickets["user_id"].should_not 									== nil
				tickets["input_params"]["providerId"].should_not 				== nil
				tickets["input_params"]["source"].should_not 					== nil
				tickets["input_params"]["destination"].should_not 				== nil
				tickets["input_params"]["date"].should_not 						== nil
				tickets["input_params"]["count"].should_not 					== nil
				tickets["input_params"]["totalFare"].should_not 				== nil
				tickets["input_params"]["boardingPoint"].should_not 			== nil
				tickets["input_params"]["boardingPointId"].should_not 			== nil
				tickets["input_params"]["droppingPoint"].should_not 			== nil
				tickets["input_params"]["droppingPointId"].should_not 			== nil
				tickets["input_params"]["selectedSeats"].should_not 			== nil
				tickets["input_params"]["passengers"].should_not 				== nil
					tickets["input_params"]["passengers"].each do |passenger|
						if passenger["primary"] 							 	== true
							passenger["name"].should_not 						== nil
							passenger["age"].should_not 						== nil
							passenger["title"].should_not 						== nil
							passenger["gender"].should_not 						== nil
							passenger["seatNumber"].should_not 					== nil
							passenger["mobileNumber"].should_not 				== nil
							passenger["email"].should_not 						== nil
							passenger["address"].should_not 					== nil
							passenger["idType"].should_not 						== nil
							passenger["idNumber"].should_not 					== nil
							passenger["idName"].should_not 						== nil
						end
					end	
				tickets["input_params"]["paymentMode"].should_not 				== nil
				tickets["input_params"]["controller"].should_not 				== nil
				tickets["input_params"]["action"].should_not 					== nil
				tickets["input_params"]["ticket"].should_not 					== nil
			end
	end

	it "Test case for BLOCKED tickets" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
		tickets_array = JSON.parse(response)
		tickets_array.each do |tickets|
			if tickets["status"] 							== "BLOCKED"
				tickets["ticket_data"].should 				== nil
				tickets["provider_ticket_id"].should 		== nil
				tickets["cancellation_charge"].should 		== nil
			end
		end
	end

	it "Test case for SOLD tickets" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
		tickets_array = JSON.parse(response)
		tickets_array.each do |tickets|
			if tickets["status"] == "SOLD"
				tickets["ticket_data"].should_not 								== nil
				tickets["provider_ticket_id"].should_not 						== nil
				tickets["cancellation_charge"].should 							== nil
				tickets["input_params"]["bankCode"].should_not 					== nil
				tickets["ticket_data"]["tin"].should_not 						== nil
				tickets["ticket_data"]["pnr"].should_not			    		== nil
				tickets["ticket_data"]["inventoryItems"].should_not 			== nil
					tickets["ticket_data"]["inventoryItems"].each do |detail|
						detail["seatName"].should_not							== nil
						detail["fare"].should_not								== nil
						detail["ladiesSeat"].should_not							== nil
						detail["passenger"].should_not							== nil
						detail["passenger"]["name"].should_not 					== nil
						# detail["passenger"]["mobile"].should_not 				== nil
						detail["passenger"]["title"].should_not 				== nil
						# detail["passenger"]["email"].should_not 				== nil	
						detail["passenger"]["age"].should_not 					== nil
						detail["passenger"]["gender"].should_not 				== nil
						detail["passenger"]["idType"].should_not 				== nil
						# detail["passenger"]["Primary"].should_not 				== nil
					end

				tickets["ticket_data"]["inventoryId"].should_not 				== nil
				tickets["ticket_data"]["doj"].should_not 						== nil
				tickets["ticket_data"]["sourceCityId"].should_not 				== nil
				tickets["ticket_data"]["pickupLocationId"].should_not 			== nil
				tickets["ticket_data"]["pickupLocation"].should_not 			== nil
				# tickets["ticket_data"]["pickupLocationAddress"].should_not  	== nil
				tickets["ticket_data"]["pickupLocationLandmark"].should_not 	== nil
				# tickets["ticket_data"]["pickupContactNo"].should_not 			== nil
				tickets["ticket_data"]["pickupTime"].should_not 				== nil
				tickets["ticket_data"]["destinationCityId"].should_not 			== nil
				tickets["ticket_data"]["cancellationPolicy"].should_not 		== nil
				tickets["ticket_data"]["status"].should_not 					== nil
				tickets["ticket_data"]["dateOfIssue"].should_not 				== nil
				tickets["ticket_data"]["busType"].should_not 					== nil
				tickets["ticket_data"]["refundAmount"].should 					== nil
				tickets["ticket_data"]["cancellationCharges"].should 			== nil
				tickets["ticket_data"]["dateOfCancellation"].should 			== nil
			end
		end
	end

	it "Test case for CANCELLED tickets" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
		tickets_array = JSON.parse(response)
		tickets_array.each do |tickets|
			if tickets["status"] 										 		== "CANCELLED"
				tickets["provider_ticket_id"].should_not 				 		== nil
				tickets["ticket_data"].should_not 						 		== nil
				tickets["input_params"]["bankCode"].should_not 			 		== nil
				tickets["input_params"]["bankCode"].should_not 					== nil
				tickets["ticket_data"]["tin"].should_not 						== nil
				tickets["ticket_data"]["pnr"].should_not			    		== nil
				tickets["ticket_data"]["inventoryItems"].should_not 			== nil
				tickets["ticket_data"]["inventoryId"].should_not 				== nil
				tickets["ticket_data"]["doj"].should_not 						== nil
				tickets["ticket_data"]["sourceCityId"].should_not 				== nil
				tickets["ticket_data"]["pickupLocationId"].should_not 			== nil
				tickets["ticket_data"]["pickupLocation"].should_not 			== nil
				# tickets["ticket_data"]["pickupLocationAddress"].should_not  	== nil
				tickets["ticket_data"]["pickupLocationLandmark"].should_not 	== nil
				# tickets["ticket_data"]["pickupContactNo"].should_not 			== nil
				tickets["ticket_data"]["pickupTime"].should_not 				== nil
				tickets["ticket_data"]["destinationCityId"].should_not 			== nil
				tickets["ticket_data"]["cancellationPolicy"].should_not 		== nil
				tickets["ticket_data"]["status"].should_not 					== nil
				tickets["ticket_data"]["dateOfIssue"].should_not 				== nil
				tickets["ticket_data"]["busType"].should_not 					== nil
				# tickets["ticket_data"]["refundAmount"].should 					== niL
				# tickets["partialCancellationAllowed"].should_not 		 		== nil
				# tickets["cancellationCharges"].should_not 						== nil
				# tickets["ticket_data"]["dateOfCancellation"].should_not  		== nil
			end

		end
	end
end

