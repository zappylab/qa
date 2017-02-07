require 'capybara/dsl'

module Finders
	include Capybara::DSL

	def find_by_id(id)
		begin
			return find(:css, '#'+ id)
		rescue Capybara::ElementNotFound
			puts "ERROR: CAN'T FIND ELEMENT WITH ID = " + id
			fail
		end
	end

	def find_by_class(classname)
		element = nil
		begin
			element = find(:css, '.' + classname)
			puts "ONE ELEMENT WAS FOUND WITH CLASSNAME = " + classname
			return element
		rescue Capybara::Ambiguous
			element = find_all(:css, '.' + classname)
			puts "AN ARRAY OF ELEMENTS WAS FOUND WITH CLASSNAME = " + classname
			return element
		rescue Capybara::ElementNotFound
			puts "ERROR: CAN'T FIND ELEMENTS WITH CLASSNAME = " + classname
		end
	end

	# tag_name, id, attribute, attribute text, InnerHTML
	def find_by(*args)
 		xpath_id = "#{args[1].to_s != '' ? "@id='#{args[1]}'" : ''}"
 		xpath_attribute = "#{args[2].to_s != '' ? "@#{args[2]}" : ''}"
 		xpath_attribute_val = "#{args[3].to_s != '' ? "#{xpath_attribute + "='#{args[3]}'"}" : ''}"
 		xpath_innerHTML = "#{args[4].to_s != '' ? "text()='#{args[4]}'" : ''}"
 		xpath_part = "#{xpath_id.to_s == '' ? '' : "[#{xpath_id}]"}#{xpath_attribute.to_s == '' ? '' : xpath_attribute_val.to_s == '' ? "[#{xpath_attribute}]" : "[#{xpath_attribute_val}]"}#{xpath_innerHTML.to_s == '' ? '' : "[#{xpath_innerHTML}]"}"
 		xpath_string = ".//#{args[0].to_s == '' ? "*" : "#{args[0]}"}#{args.size > 1 ? "#{xpath_part}" : '' }"
 		begin
			elements = find(:xpath, xpath_string)
			puts "ONE ELEMENT WAS FOUND WITH #{args}"
			return elements
		rescue Capybara::Ambiguous
			elements = find_all(:xpath, xpath_string)
			puts "AN ARRAY OF ELEMENTS WAS FOUND WITH #{args}"
			return elements
		rescue Capybara::ElementNotFound
			puts "ERROR: CAN'T FIND ELEMENTS WITH #{args}"
		end
	end

end