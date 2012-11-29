require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

describe "Get /tickets/:id/cancel" do

	it "should return 400 authorized for the past date" do
			id = "100000006944312427"
			auth_url = "http://tickets.paytm.com/trip/#{id}/1"
			RestClient.get(auth_url) do |response, request, result, &block|
				response.code.should == 400
				puts response
			end
	end

	it "should return 200 authorized" do
			id = "100000007004312427"
			auth_url = "http://tickets.paytm.com/trip/#{id}/1"
			RestClient.get(auth_url) do |response, request, result, &block|
				response.code.should == 200
				trip_array = JSON.parse(response)
				puts trip_array
				trip_array.length.should > 0
				trip_array.is_a? (Array)
				if true then 
					puts "Output is an array" 
				else 
					puts "Output is not an array"
				end

				trip_array.each do |seat_detail|
					seat_detail["isAvailable"].should_not 		== nil
					seat_detail["fare"].should_not 				== nil
					seat_detail["isLadiesSeat"].should_not 		== nil
					seat_detail["seatName"].should_not 			== nil
					seat_detail["isLowerBerth"].should_not 		== nil
					seat_detail["row"].should_not 				== nil
					seat_detail["column"].should_not 			== nil
					seat_detail["length"].should_not 			== nil
					seat_detail["width"].should_not 			== nil
				end
			end
	end
end
