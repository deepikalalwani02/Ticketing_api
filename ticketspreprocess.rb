require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets.paytm.com/tickets/preprocess"

describe "POST /tickets/preprocess" do
	it "should return unauthorized" do
		RestClient.post(url,{}.to_json) do |response, request, result, &block|
			puts response.inspect
			response.code.should == 400 
	      end
      end

    it "should be authorized" do
		RestClient.post url, {"tripId" => "100000006954098093", "providerId" => "1", "source" => "Bangalore", "destination" => "Thiruvarur", "date" => "2012-11-26", "count" => "1", "totalFare" => 805, "boardingPoint" => "Wilson Garden (08:00 PM)", "boardingPointId" => "77840", "droppingPoint" => "Thiruvaroor (06:15 AM)", "droppingPointId" => "54865", "selectedSeats" =>["L21"], "applyCoupon" => false, "passengers" => [{"name" => "Sourav Upadhyay", "age" => "32", "title" => "mr", "gender" => "male", "primary" => true, "seatNumber" => "L21", "mobileNumber" => "8130933428", "alternateMobileNumber" => " ", "email" => "Sourav.upadhyay@one97.net", "address" => "Noida, UP", "idType" => "PAN card", "idNumber" => "BZQ1`23123", "idName" => "John Doe"}], "paymentMode" => "cc", "bankId" => "5"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 200
                  detail = JSON.parse(response)
                  puts detail
        end
    end
end

