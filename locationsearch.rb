require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets-staging.paytm.com/locations/search"

describe "POST /locations/search" do
	it "should return unauthorized" do
		RestClient.post(url,{}.to_json) do |response, request, result, &block|
			puts response.inspect
			response.code.should == 500 
	    end
    end
    it "should return unauthorized when provider location is is missing" do
		RestClient.post url, {"provider_id" => 1, "source" => "Gargoti", "destination" => "Mumbai", "is_boarding_point" => "true"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 400
			puts response.inspect

		end
	end

	it "should return unauthorized when provider id is missing" do
		RestClient.post url, {"provider_location_id" => 127772, "source" => "Gargoti", "destination" => "Mumbai", "is_boarding_point" => "true"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 400
			puts response.inspect

		end
	end

	it "should return unauthorized when source is missing" do
		RestClient.post url, {"provider_location_id" => 127772, "provider_id" => 1, "destination" => "Mumbai", "is_boarding_point" => "true"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 500
			puts response.inspect

		end
	end

	it "should return unauthorized when destination is missing" do
		RestClient.post url, {"provider_location_id" => 127772, "provider_id" => 1, "source" => "Gargoti", "is_boarding_point" => "true"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 500
			puts response.inspect

		end
	end

	it "should return unauthorized when boarding point is missing" do
		RestClient.post url, {"provider_location_id" => 127772, "provider_id" => 1, "source" => "Gargoti", "destination" => "Mumbai",}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 400
			puts response.inspect

		end
	end

	it "should search the data" do
		RestClient.post url, {"provider_location_id" => 127772, "provider_id" => 1, "source" => "Gargoti", "destination" => "Mumbai", "is_boarding_point" => "true"}.to_json, :content_type => :json, :accept => :json do |response, request, result, &block|
			response.code.should == 200
                  bus_detail = JSON.parse(response)
                  puts bus_detail
                  bus_detail.length.should > 0
                  bus_detail["address"].should_not		== nil
                  bus_detail["name"].should_not	    	== nil
                  bus_detail["short_name"].should_not	== nil
                  bus_detail["landmark"].should_not	    == nil
                  bus_detail["latitude"].should_not	    == nil
                  bus_detail["longitude"].should_not	== nil


                  	
        end
    end
end

