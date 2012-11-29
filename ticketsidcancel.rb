require 'rubygems'
require 'json'
require 'rest_client'
require 'rspec'

describe "Get /tickets/:id/cancel" do
	it "should return 200 authorized" do
		response = RestClient::Resource.new("http://tickets-staging.paytm.com/admin/index", "one97-admin", "@neNine7").get
		response = RestClient.get("http://tickets-staging.paytm.com/tickets", :Cookie => response.headers[:set_cookie][0])
			tickets_array = JSON.parse(response)
			ticket_length = tickets_array.length
			index = rand(ticket_length)
			ticket = tickets_array[index]
			id = ticket["id"]
			puts id
			auth_url = "http://tickets.paytm.com/tickets/#{id}/cancel"
			RestClient.put(auth_url) do |response, request, result, &block|

			end
		
	end
end
