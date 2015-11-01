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
			puts "That aint gonna work, try again!"
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
			print "Enter contact id number for the contact to edit: "
			receive_id("to modify")
	end

	def display_all_contacts
		puts Contact.all.inspect
	end

	def display_contact
	end

	def delete_contact
		print "Enter contact id number for contact to edit: "
		receive_id("to delete")
	end

# receives contact id from user
	def receive_id(action)
		id = gets.chomp.to_i
		check_id(id, action)
	end

# checks the id against the contacts array and confirms it with the user
	def check_id(id, action)
		contact = Contact.find(id)
		if contact.is_a? Contact
			puts "Name: #{contact.full_name}, Email:#{contact.email}, ID:#{contact.id}"
			print "Is this the correct contact? Enter Y OR N: "
			confirm = gets.chomp.to_s.upcase
				if confirm == "Y" && action == "to modify"
					prompt_changes(id)
				elsif confirm == "Y" && action =="to delete"
					Contact.delete(id)
				elsif confirm == "N"
					main_menu
				else
					puts "Invalid option, please enter Y OR N"
					check_id(id)
				end
		else
			puts "Invalid ID number"
			receive_id
		end
	end

# asks for attribute to be changed after user has confirmed contact to modify
	def prompt_changes(id)
		puts "What do you want to change? Enter a number from below."
		print "First Name: 1  Last Name: 2  Email: 3  Notes: 4: "
		choice = gets.chomp.to_i
		case
		when choice == 1
			print "Enter new First Name: "
			first_name = gets.chomp.to_s
			Contact.update(id, choice, first_name)
		when choice == 2
			print "Enter new Last Name: "
			last_name = gets.chomp.to_s
			Contact.update(id, choice, last_name)
		when choice == 3
			print "Enter new Email: "
			email = gets.chomp.to_s
			Contact.update(id, choice, email)
		when choice == 4
			puts "Enter new Notes: "
			notes = gets.chomp.to_s
			Contact.update(id, choice, notes)
		else
			puts "Invalid Input: "
			prompt_changes(id)
		end
		print "Do you wish to change another attribute? Enter Y or N: "
		confirm = gets.chomp.to_s.upcase
		if confirm == "Y"
			prompt_changes(id)
		elsif confirm == "N"
			main_menu
		else
			puts "Invalid input, returning to main menu"
			main_menu
		end
	end
end

my_awesome_crm = CRM.new('Bitmaker CRM')
Contact.create("j", "m")
Contact.create("m", "l")
Contact.create("p", "p")
my_awesome_crm.main_menu

