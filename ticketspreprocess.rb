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

    it "should be 200 authorized" do
		RestClient.post url, {"tripId" => "100000006994027517", "providerId" => "1", "source" => "Delhi", "destination" => "Dehradun", "date" => "2012-11-30", "count" => 1, "totalFare" => 450, "boardingPoint" =>"Cannaught Place (09:15 PM)", "boardingPointId" => "32015", "droppingPoint" => "Dehradun (05:30 AM)", "droppingPointId" =>"32018" ,"selectedSeats" => ["06"],"applyCoupon" => false,"passengers" => [{"name" => "dfsdfs","age" => "22","title" => "Ms","gender" => "female","primary" => true,"seatNumber" => "04","mobileNumber" => "8447045300","alternateMobileNumber" => " ","email" => "deepika.lalwani@one97.net","address" => "88B, pocket -f, Dilshad Garden, New Delhi - 110085","idType" => "pancard","idNumber" => "asd632bcd9","idName" => "John Doe"}],"paymentMode" => "cc","bankId" => "6"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 200
                  detail = JSON.parse(response)
                  puts "THE RESPONSE IS :"
                  puts detail

        end
    end
    it "should be 200 authorized after 20 minutes" do
    	sleep(1260)
		RestClient.post url, {"tripId" => "100000006994027517", "providerId" => "1", "source" => "Delhi", "destination" => "Dehradun", "date" => "2012-11-30", "count" => 1, "totalFare" => 450, "boardingPoint" =>"Cannaught Place (09:15 PM)", "boardingPointId" => "32015", "droppingPoint" => "Dehradun (05:30 AM)", "droppingPointId" =>"32018", "selectedSeats" => ["06"], "applyCoupon" => false,"passengers" => [{"name" => "dfsdfs", "age" => "22", "title" => "Ms", "gender" => "female", "primary" => true, "seatNumber" => "04", "mobileNumber" => "8447045300", "alternateMobileNumber" => " ", "email" => "deepika.lalwani@one97.net", "address" => "88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType" => "pancard", "idNumber" => "asd632bcd9", "idName" => "John Doe"}], "paymentMode" => "cc", "bankId" => "6"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 200
                  detail = JSON.parse(response)
                  puts "THE RESPONSE IS :"
                  puts detail
        end
    end

    it "should be 428 error for 1 - 19 minutes" do
    	sleep(600)
		RestClient.post url, {"tripId" => "100000006994027517", "providerId" => "1", "source" => "Delhi", "destination" => "Dehradun", "date" => "2012-11-30" ,"count" => 1, "totalFare" => 450, "boardingPoint" =>"Cannaught Place (09:15 PM)" ,"boardingPointId" => "32015", "droppingPoint" => "Dehradun (05:30 AM)", "droppingPointId" =>"32018", "selectedSeats" => ["06"], "applyCoupon" => false, "passengers" => [{"name" => "dfsdfs", "age" => "22", "title" => "Ms", "gender" => "female", "primary" => true, "seatNumber" => "04", "mobileNumber" => "8447045300", "alternateMobileNumber" => " ", "email" => "deepika.lalwani@one97.net", "address" => "88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType" => "pancard", "idNumber" => "asd632bcd9", "idName" => "John Doe"}], "paymentMode" => "cc", "bankId" => "6"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 428
                  detail = JSON.parse(response)
                  puts "THE RESPONSE IS :"
                  puts detail

        end
    end
end
 #    it "should Respond properly for trip id is wrong or missing " do
	# 	RestClient.post url, {"providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 						 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
 #                detail = JSON.parse(response)
 #                puts "THE RESPONSE IS :"
 #                puts detail

 #        end
 #    end
 #    it "should Respond properly for provider id is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	# it "should Respond properly for source is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	# it "should Respond properly for destination is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	# it "should Respond properly for date is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	# it "should Respond properly for boardingPoint is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	
	# it "should Respond properly for passengers detail is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "paymentMode"=>"cc", "bankId"=>"5"}
	# 								 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 		response.code.should == 400
	# 	        detail = JSON.parse(response)
	# 	        puts "THE RESPONSE IS :"
	# 	        puts detail
	# 	end
	# end
	# it "should Respond properly for paymentMode is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "bankId"=>"5"}
	# 							 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 			response.code.should == 400
	#                   detail = JSON.parse(response)
	#                   puts "THE RESPONSE IS :"
	#                   puts detail
	#     end
 #    end
 #    it "should Respond properly for bank id is wrong or missing " do
	# 	RestClient.post url, {"tripId"=>"100000007084103194", "providerId"=>"1", "source"=>"Chennai", "destination"=>"Bangalore", "date"=>"2012-12-09", "count"=>1, "totalFare"=>400, "boardingPoint"=>"Adyar (12:00 AM)", "boardingPointId"=>"68618", "droppingPoint"=>"Madiwala (08:00 PM)", "droppingPointId"=>"56469", "selectedSeats"=>["30"], "applyCoupon"=>false, "passengers"=>[{"name"=>"sakljdalksdj", "age"=>"22", "title"=>"Mr", "gender"=>"male", "primary"=>true, "seatNumber"=>"30", "mobileNumber"=>"8912371237", "alternateMobileNumber"=>" ", "email"=>"mayank.jain@one97.net", "address"=>"88B, pocket -f, Dilshad Garden, New Delhi - 110085", "idType"=>"pancard", "idNumber"=>"asd632bcd9", "idName"=>"John Doe"}], "paymentMode"=>"cc"}
	# 							 .to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
	# 			response.code.should == 400
	#                   detail = JSON.parse(response)
	#                   puts "THE RESPONSE IS :"
	#                   puts detail
	#     end
 #    end

