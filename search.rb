require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets-staging.paytm.com/search"

describe "POST /search" do
	it "should return unauthorized" do
		RestClient.post(url,{}.to_json) do |response, request, result, &block|
			puts response.inspect
			response.code.should == 400 
	      end
      end

      it "should return bad request when travelling date has already passed" do
            RestClient.post url, {"source" => "Aurangabad", "destination" => "pune", "date" => "2012-01-25", "count" => "1"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
                  puts response.inspect
                  response.code.should == 400
            end
      end

      it "should return unauthorized when source is unknown" do
            RestClient.post url, {"destination" => "pune", "date" => "2013-01-25", "count" => "1"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
                  puts response.inspect
                  response.code.should == 400
            end
      end

      it "should return unauthorized when destination is unknown" do
            RestClient.post url, {"source" => "Aurangabad", "date" => "2013-01-25", "count" => "1"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
                  puts response.inspect
                  response.code.should == 400
            end
      end

      it "should return unauthorized when date is unknown" do
            RestClient.post url, {"source" => "Aurangabad","destination" => "pune", "count" => "1"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
                  puts response.inspect
                  response.code.should == 400
            end
      end

      it "should return unauthorized when count is unknown" do
            RestClient.post url, {"source" => "Aurangabad","destination" => "pune", "date" => "2013-01-25"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
                  puts response.inspect
                  response.code.should == 400
            end
      end

	it "should search the data" do
		RestClient.post url, {"source" => "Aurangabad", "destination" => "pune", "date" => "2013-01-25", "count" => "1"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 200
                  bus_detail = JSON.parse(response)
                  puts bus_detail
                  bus_detail.each do |data|
                        if data["tripId"] == "100000007554224145"
                              data["travelDurationDays"].should_not            == nil
                              data["arrivalTime"].should_not                   == nil
                              data['avalableSeats'].should_not                 == nil
                              data['isAc'].should_not                          == nil
                              data['isSleeper'].should_not                     == nil
                              data['isMobileTicketAllowed'].should_not         == nil
                              data['busType'].should_not                       == nil
                              data['cancellationPolicy'].should_not            == nil
                              data['partialCancellationAllowed'].should_not    == nil
                              data['fare'].should_not                          == nil
                              data['travelsName'].should_not                   == nil
                              data['providerId'].should_not                    == nil
                              puts "The Number of boarding locations are :" + data["boardingLocations"].length.to_s
                              data["boardingLocations"].length.should > 0
                              data["boardingLocations"].each do |board|
                                    board["providerLocationId"].should_not     == nil
                                    board["locationName"].should_not           == nil
                                    board["time"].should_not                   == nil
                              end
                              puts "The Number of droppingLocations locations are :" + data["droppingLocations"].length.to_s
                              data["droppingLocations"].length.should > 0
                              data["droppingLocations"].each do |drop|
                                    drop["providerLocationId"].should_not     == nil
                                    drop["locationName"].should_not           == nil
                                    drop["time"].should_not                   == nil
                              end

                        end
                  end
            end
	end
end




