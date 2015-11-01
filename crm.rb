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
		when 2 then receive_id("modify")
		when 3 then display_all_contacts
		when 4 then receive_id("display")
		when 5 then display_contact_attribute
		when 6 then receive_id("delete")
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

	def display_all_contacts
		puts Contact.all.inspect
	end

	def display_contact(contact)
		puts "First name: #{contact.first_name}\nLast name: #{contact.last_name}\nEmail: #{contact.email}\nNotes: #{contact.notes}\n"
	end

	def delete_contact(id)
		print "Are you sure you wish to delete? We can't bring them back. Y or N: "
		confirm = gets.chomp.to_s.upcase
		if confirm == "Y"
			Contact.delete(id)
		elsif confirm == "N"
			puts "Contact NOT deleted"
			main_menu
		else
			puts "invalid input. You must enter Y or N"
			delete_contact(id)
		end
	end

# receives contact id from user
	def receive_id(action)
		print "Enter contact ID number to perform #{action} action on: "
		id = gets.chomp.to_i
		check_id(id, action)
	end

# checks the id against the contacts array and confirms it with the user
	def check_id(id, action)
		contact = Contact.find(id)
		if contact.is_a? Contact
			case
			when action == "display"
				display_contact(contact)
			when action == "delete" || action == "modify"
				puts "Name: #{contact.full_name}, ID:#{contact.id}"
				print "Is this the correct contact? Enter Y OR N: "
				confirm = gets.chomp.to_s.upcase
				if confirm == "Y" && action == "modify"
					modify_contact(id)
				elsif confirm == "Y" && action == "delete"
					delete_contact(id)
				elsif confirm == "N"
					receive_id(action)
				else
					puts "Invalid option, please enter Y OR N"
					check_id(id, action)
				end
			end
		else
			puts "Invalid ID number"
			receive_id(action)
		end
	end


# asks for attribute to be changed after user has confirmed contact to modify
	def modify_contact(id)
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
			modify_contact(id)
		end
		print "Do you wish to change another attribute? Enter Y or N: "
		confirm = gets.chomp.to_s.upcase
		if confirm == "Y"
			modify_contact(id)
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

