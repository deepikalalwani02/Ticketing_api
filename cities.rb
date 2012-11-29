require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets-staging.paytm.com/cities"

describe "GET /Cities" do
	it "should return 200 authorized" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 200
			list_array = JSON.parse(response)
			list_array.length.should > 0
			list_array.is_a? (Array)
			if true then 
				puts "Output is an array" 
			else 
				puts "Output is not an array"
			end
			list_array.each do |city|
					city["id"].should_not 		  == nil
					city["name"].should_not       == nil
					city['short_name'].should_not == nil
			
			end
	    end
	end	

    it "Test case for unique short name " do
	    RestClient.get(url) do |response, request, result, &block|
	    	city_list = JSON.parse(response)
	    	if short_name = city_list.collect {|c| c["short_name"]}
				short_name.uniq.length == short_name.length
				puts " SHORT NAME IS UNIQUE"
			else
				puts "SHORT NAME IS NOT UNIQUE"
			end
			
			city_list.each do |city|
				city["id"].should_not < 0
				if city["id"] == 1

					city["name"].should       == "Delhi"
					city['short_name'].should == "delhi"
			 	end
			end
		end
   end
end


