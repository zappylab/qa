require_relative './spec_helper.rb'

describe 'SIGN UP protocols app, VERIFY acc , SIGN in app, DELETE acc' do

	# it 'should SIGN UP into app' do
	# 	$loginPage = LoginPageClass.new
	# 	$loginPage.sign_up "protocolsuitest@gmail.com", "protocols-ui-123"
	# end

	# it 'should VEFIRY new acc' do
	# 	$gmail = GoogleEmailClass.new
	# 	$gmail.verify_email 'protocolsuitest@gmail.com', 'protocols-ui-123', 'verifying'
	# end

	# it 'should SIGN IN the protocols app' do
	# 	$loginPage = LoginPageClass.new
	# 	startPage = $loginPage.sign_in 'protocolsuitest@gmail.com', 'protocols-ui-123'
	# 	startPage.sign_out
	# end

	# it 'should DELETE activated acc' do
	# 	$loginPage = LoginPageClass.new
	# 	$protocolsStartPage = $loginPage.sign_in 'protocolsuitest@gmail.com', 'protocols-ui-123'
	# 	userProfilePage = $protocolsStartPage.go_to_user_profile
	# 	userProfilePage.delete_user
	# end

	it 'should SIGN UP into app via g+' do
		$loginPage = LoginPageClass.new
		$loginPage.sign_up_gmail('protocolsuitest@gmail.com', 'protocols-ui-123')
	end
end