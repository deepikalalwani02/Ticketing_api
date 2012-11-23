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
end
