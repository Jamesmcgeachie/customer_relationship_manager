class Contact

	attr_reader :id
	attr_accessor :first_name, :last_name, :email, :notes

	@@contacts = []
	@@id = 1

	def initialize(first_name, last_name, options = {})
		@first_name = first_name
		@last_name = last_name
		@email = options[:email]
		@notes = options[:notes]
		@id = @@id
		@@id += 1
	end

	def self.create(first_name, last_name, options = {})
		new_contact = new(first_name, last_name, options)
		@@contacts << new_contact
		puts "#{first_name} has been added to contacts."
	end

	def self.all
		@@contacts
	end

	def self.find(id)
		@@contacts.each do |contact|
			if contact.id == id
				return contact
			end
		end
		return nil
	end

	def self.display(attribute)
		@@contacts.each do |contact|
			if attribute == 1
				puts "First Name: #{contact.first_name}"
			elsif attribute == 2
				puts "Last Name: #{contact.last_name}"
			elsif attribute == 3
				puts "Email: #{contact.email}"
			elsif attribute == 4
				puts "Notes: #{contact.notes}"
			else
				puts "This shouldn't be possible"
			end
		end
	end

	def self.update(id, attribute, new_value)
		to_change = find(id)
		if attribute == 1
			to_change.first_name = new_value
		elsif attribute == 2
			to_change.last_name = new_value
		elsif attribute == 3
			to_change.email = new_value
		elsif attribute == 4
			to_change.notes = new_value
		else
			puts "Something went badly wrong here"
		end
		puts "Changes saved!"
	end

	def self.delete(id)
		to_delete = find(id)
		@@contacts.delete_at(@@contacts.index(to_delete))
		puts "Contact #{id} has been deleted"
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end