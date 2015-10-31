require_relative 'contact.rb'

class CRM
	def initialize(name)
		@name = name
	end

	def print_main_menu
		puts "1. Add a contact"
		puts "2. Modify a contact"
		puts "3. Display all contacts"
		puts "4. Display contact"
		puts "5. Delete a contact attribute"
		puts "6. Delete a contact"
		puts "7. Exit"
	end

	def main_menu
		while true
			print_main_menu
			print "Choose an option: "
			user_input = gets.chomp.to_i
			break if user_input == 7
			choose_option(user_input)
		end
	end

	#(input) here it coming from the (user_input) in the main_menu method
	def choose_option(input)
		case input
		when 1 then add_contact
		when 2 then modify_contact
		when 3 then display_all_contacts
		when 4 then display_contact
		when 5 then display_contact_attribute
		when 6 then delete_contact
		when 7 then exit
		else
			puts "I'm sorry Dave, I'm afraid you can't do that."
		end
	end

	def add_contact
		print "First name: "
		first_name = gets.chomp

		print "Last name: "
		last_name = gets.chomp

		print "Email: "
		email = gets.chomp

		print "Notes: "
		notes = gets.chomp

		Contact.create(first_name, last_name, email: email, notes: notes)
	end

	def modify_contact
			receive_id
	end

	def receive_id
		print "Enter contact id number for contact to edit: "
		id = gets.chomp.to_i
		check_id(id)
	end

	def check_id(id)
		contact = Contact.find(id)
		if contact.is_a? Contact
			puts "#{contact.inspect} is this the correct contact? Enter Y OR N"
			confirm = gets.chomp.to_s
				if confirm == "Y"
					prompt_changes
				elsif confirm == "N"
					receive_id
				else
					puts "Invalid option, please enter Y OR N"
					check_id(id)
				end
		else
			puts "Invalid ID number"
		end
	end

	def prompt_changes
		puts "what do you want to change? Enter a number"
		print "First Name: 1  Last Name: 2  Email: 3  Notes: 4: "
		choice = gets.chomp
	end

	def display_all_contacts
		puts Contact.all.inspect
	end

# really shouldn't be rewriting this code, needs to fix all this.
	def delete_contact
				print "Enter contact id number for contact to edit: "
				id = gets.chomp.to_i
				check_id(id)
				Contact.delete(id)
	end
end



my_awesome_crm = CRM.new('Btmaker CRM')
my_awesome_crm.main_menu