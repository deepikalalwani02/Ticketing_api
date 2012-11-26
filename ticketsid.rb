require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets-staging.paytm.com/tickets/:id"
describe "Get /tickets/:id" do
	it "should return 400 unauthorized" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 418
			puts response.inspect

		end
	end

	it "should return 200 authorized" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
			tickets_array = JSON.parse(response)
			ticket_length = tickets_array.length
			index = rand(ticket_length)
			ticket = tickets_array[index]
			id = ticket["id"]
			puts id
			auth_url = "http://tickets-staging.paytm.com/tickets/#{id}"
			RestClient.get(auth_url) do |response, request, result, &block|
				puts response
				response.code.should == 200
				ticket_data = JSON.parse(response)
				ticket_data.is_a? (Array)
				if true then 
					puts "Output is an array" 
					else 
					puts "Output is not an array"
				end

			end
	end

	it "Test cases for BOOKED , SOLD, CANCELLED" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
			tickets_array = JSON.parse(response)
			ticket_length = tickets_array.length
			index = rand(ticket_length)
			ticket = tickets_array[index]
			id = ticket["id"]
			puts id
			# id = "d182330b2823c07e591836ac9c0f7619"
			auth_url = "http://tickets-staging.paytm.com/tickets/#{id}"
			RestClient.get(auth_url) do |response, request, result, &block|
				# puts response
				response.code.should == 200
				ticket_data = JSON.parse(response)
				if ticket_data["status"] 												== "BLOCKED"
					puts "TICKET IS BLOCKED"
					ticket_data["ticket_data"].should 									== nil
					ticket_data["provider_ticket_id"].should 							== nil
					ticket_data["cancellation_charge"].should 							== nil

					else if ticket_data["status"] 											== "SOLD"
						puts "TICKET IS SOLD"
						ticket_data["ticket_data"].should_not 								== nil
						ticket_data["provider_ticket_id"].should_not 						== nil
						ticket_data["cancellation_charge"].should 							== nil
						ticket_data["input_params"]["bankCode"].should_not 					== nil
						ticket_data["ticket_data"]["tin"].should_not 						== nil
						ticket_data["ticket_data"]["pnr"].should_not			    		== nil
						ticket_data["ticket_data"]["inventoryItems"].should_not 			== nil
						ticket_data["block_key"].should_not 								== nil
						ticket_data["created_at"].should_not 								== nil
						ticket_data["destination_city_id"].should_not 						== nil
						# ticket_data["fare"].should_not 									== nil
						ticket_data["id"].should_not 										== nil
						ticket_data["is_feedback_sms_send"].should_not 						== nil
						ticket_data["passenger_count"].should_not 							== nil
						ticket_data["provider_id"].should 									== 1
						ticket_data["source_city_id"].should_not 							== nil
						ticket_data["status"].should_not 									== nil
						ticket_data["transaction_id"].should_not 							== nil
						ticket_data["travel_date"].should_not 								== nil
						ticket_data["uid"].should_not 										== nil
						ticket_data["updated_at"].should_not 								== nil
						ticket_data["user_id"].should_not 									== nil
						ticket_data["input_params"]["providerId"].should_not 				== nil
						ticket_data["input_params"]["source"].should_not 					== nil
						ticket_data["input_params"]["destination"].should_not 				== nil
						ticket_data["input_params"]["date"].should_not 						== nil
						ticket_data["input_params"]["count"].should_not 					== nil
						ticket_data["input_params"]["totalFare"].should_not 				== nil
						ticket_data["input_params"]["boardingPoint"].should_not 			== nil
						ticket_data["input_params"]["boardingPointId"].should_not 			== nil
						ticket_data["input_params"]["droppingPoint"].should_not 			== nil
						ticket_data["input_params"]["droppingPointId"].should_not 			== nil
						ticket_data["input_params"]["selectedSeats"].should_not 			== nil
						ticket_data["input_params"]["passengers"].should_not 				== nil
						ticket_data["input_params"]["passengers"].each do |passenger|
							if passenger["primary"] 							 			== true
								passenger["name"].should_not 								== nil
								passenger["age"].should_not 								== nil
								passenger["title"].should_not 								== nil
								passenger["gender"].should_not 								== nil
								passenger["seatNumber"].should_not 							== nil
								passenger["mobileNumber"].should_not 						== nil
								passenger["email"].should_not 								== nil
								passenger["address"].should_not 							== nil
								passenger["idType"].should_not 								== nil
								passenger["idNumber"].should_not 							== nil
								passenger["idName"].should_not 								== nil
							end
						end
						ticket_data["input_params"]["paymentMode"].should_not 				== nil
						ticket_data["input_params"]["controller"].should_not 				== nil
						ticket_data["input_params"]["action"].should_not 					== nil
						ticket_data["input_params"]["ticket"].should_not 					== nil

						else if ticket_data["status"] 										== "CANCELLED"
						puts "TICKET IS CANCELLED"
						ticket_data["ticket_data"].should_not 								== nil
						ticket_data["provider_ticket_id"].should_not 						== nil
						ticket_data["cancellation_charge"].should_not 						== nil
						ticket_data["uid"].should_not 										== nil
					end
				end
			end
		end
	end 
end
