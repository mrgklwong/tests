Given(/^I have testing endpoint "([^"]*)"$/) do |url|
  @uri = URI.parse(url)
end

#to do, why am i passing in a parameter?
And(/^I want to test the (.*) POST$/) do |arg|
  @request = Net::HTTP::Post.new(@uri)
  @request.content_type = "application/json"
end

And(/^I add the following unique id "([^"]*)"$/) do |id|
  @id = id
end

When(/^I make the post$/) do
  @response = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == "https") do |http|
    http.request(@request)
  end
end


Then(/^I should get the following (.*) and (.*)$/) do |type, object|
  response_object = JSON.parse(@response.body)
  expect(response_object[0]["body"]["#{type}"].to_s).to include "#{object}"
end

#todo combine the above and below
Then(/^response should be valid compared to the schema$/) do
  response_object = JSON.parse(@response.body)
  result = JSON::Validator.validate(@schema,response_object[0]["body"])
  expect(result).to be true
  ap( JSON.parse(@schema),:plain => true)
  ap("<br>Expected the above to validate on below<br>",:plain => true)
  ap(response_object[0]["body"],:plain => true)
end

And (/^I build the post body for (.*)$/) do |connector|
  @request.body = File.read("#{connector}_post.json")
end

And(/^I add the following value "([^"]*)"$/) do |arg|
  @value = arg
end

Given(/^I have the schema for (.*)$/) do |connector|
  @schema = File.read("#{connector}.json")
end

#this is lasy, but I like to DRY
When(/^I have a valid response for (.*)$/) do |connector|
  step 'I have testing endpoint "https://edy585mx12.execute-api.eu-west-1.amazonaws.com/prod"'
  step "I want to test the #{connector} POST"
  step "I build the post body for #{connector}"
  step 'I make the post'
end