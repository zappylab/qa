require_relative './spec_helper.rb'

describe 'SIGN UP protocols app, VERIFY acc , SIGN in app, DELETE acc' do

	it 'should SIGN UP into app' do
		$loginPage = LoginPageClass.new
		$loginPage.sign_up "protocolsuitest5@gmail.com", "pizzahut123"
	end

	it 'should VEFIRY new acc' do
		$gmail = GoogleEmailClass.new
		$gmail.verify_email 'protocolsuitest5@gmail.com', 'pizzahut123', 'verifying'
	end

	it 'should SIGN IN the protocols app' do
		$loginPage = LoginPageClass.new
		startPage = $loginPage.sign_in 'protocolsuitest5@gmail.com', 'pizzahut123'
		startPage.sign_out
	end

	it 'should DELETE activated acc' do
		$loginPage = LoginPageClass.new
		$protocolsStartPage = $loginPage.sign_in 'protocolsuitest5@gmail.com', 'pizzahut123'
		userProfilePage = $protocolsStartPage.go_to_user_profile
		userProfilePage.delete_user
	end
end