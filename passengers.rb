require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

url = "http://tickets.paytm.com/passengers"

describe "Get /passengers" do
	it "should return 400 unauthorized" do
		RestClient.get(url) do |response, request, result, &block|
			response.code.should == 401
			puts response.inspect

		end
	end
	it "should return 200 authorized" do
		response = RestClient::Resource.new("http://hub.paytm.com/user/authenticate", "8447045300", "TAMANNAA02").get
			response = RestClient.get("http://tickets.paytm.com/passengers")
			puts response
		end
end