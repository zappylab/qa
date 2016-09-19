require './spec_helper.rb'
require 'capybara/rspec'


feature "Sign up, verify acc, sign in and delete acc" do
	scenario "sign up in protocols.io" do
		sign_up "protocolsuitest@gmail.com", "protocols-ui-123"
	end

	scenario "verify acc via Gmail" do
		verify_email
	end

	scenario "sign in the app with verified acc" do
		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
	end

	scenario "delete protocols account" do
		sign_in "protocolsuitest@gmail.com", "protocols-ui-123"
		delete_user "protocolsuitest@gmail.com", "protocols-ui-123"
	end
end


=begin
describe 'home_page' do
	it 'user welcome' do
		visit 'http://je-protocols'
	end
end
=end