require_relative 'contact.rb'

class CRM
	def initialize(name)
		@name = name
	end


	def print_main_menu
		puts "-----------"
		puts "1. Add a contact"
		puts "2. Modify a contact"
		puts "3. Display all contacts"
		puts "4. Display contact"
		puts "5. Display a contact attribute"
		puts "6. Delete a contact"
		puts "7. Exit"
		puts "-----------"
	end


	def main_menu
		while true
			print_main_menu
			print "Choose an option: "
			user_input = gets.chomp.to_i
			choose_option(user_input)
		end
	end


	def choose_option(input)
		case input
		when 1 then add_contact
		when 2 then receive_id("modify")
		when 3 then display_all_contacts
		when 4 then receive_id("display")
		when 5 then receive_attribute("display all of")
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


	def modify_contact(id, choice, action)
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
			receive_attribute(action, id)
		end
		print "Do you wish to change another attribute? Enter Y or N: "
		confirm = gets.chomp.to_s.upcase
		if confirm == "Y"
			receive_attribute(action, id)
		elsif confirm == "N"
			main_menu
		else
			puts "Invalid input, returning to main menu"
			main_menu
		end
	end


	def display_all_contacts
		Contact.all.each do |contact|
			puts "ID: #{contact.id}. Name: #{contact.full_name} Email: #{contact.email}"
		end
	end


	def display_contact(contact)
		puts "First name: #{contact.first_name}\nLast name: #{contact.last_name}"
		puts "Email: #{contact.email}\nNotes: #{contact.notes}\n"
	end


	def display_contact_attribute(choice, action)
		if (1..4).include? choice
			Contact.display(choice)
		else
			puts "Invalid attribute number to display, enter 1, 2, 3 or 4"
			receive_attribute(action)
		end
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


 # The 3 methods below this point are used for receiving the ID or an attribute for the user
 # I made them separate methods as they are reused

	def receive_id(action)
		print "Enter contact ID number to perform #{action} action on: "
		id = gets.chomp.to_i
		check_id(id, action)
	end


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
					receive_attribute(action, id)
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


	def receive_attribute(action, id = nil )
		puts "What do you want to #{action}? Enter a number from below."
		print "First Name: 1  Last Name: 2  Email: 3  Notes: 4: "
		choice = gets.chomp.to_i
		case
		when action == "modify"
			modify_contact(id, choice, action)
		when action == "display all of"
			display_contact_attribute(choice, action)
		end
	end

	def exit
		abort()
	end
end

my_awesome_crm = CRM.new('Bitmaker CRM')
Contact.create("James", "Mcgeachie", { email: "james@james.com", notes:"Hey it's me!"})
Contact.create("Mr", "Lemon", { email: "mrlemon@lemonpeople.com", notes: "This guy is a lemon I guess" })
Contact.create("Peter", "Pest", { email: "peter@pests.com", notes: "Peter is such a pest!" })
Contact.create("Barry", "Burton", { email: "barry@stars.com", notes: "'You were almost a Jill sandwich!'" })
my_awesome_crm.main_menu

