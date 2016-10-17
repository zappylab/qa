require 'capybara/dsl'

class GroupsInDiscussionPageClass
	include Capybara::DSL
	include BaseLibModule

	def add_post(post_text)
		t_mce_frame = find(:css, "div.wrap.tinymce-block #comment-mce-main_ifr")
		within_frame t_mce_frame do
			find("#tinymce").set(post_text)
		end
		find(:css, ".new-comment-nav .btn-blue").click
		page.has_selector?(:xpath, ".//div[@class='text-comments-block tcb-main']
			//*/div[contains(@class, 'comment-top left')]
			//*/p[contains(text(), '" + post_text +"')]")
	end
end