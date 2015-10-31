class Contact

	attr_reader :id
	attr_accessor :first_name, :last_name, :email, :notes

	@@contacts = []
	@@id = 1

	# good to use = nil if setting a non-mandatory paramater as it evaluates to false. An empty string = true.
	# example: def initialize(first_name, last_name, email, notes = nil)
	# below is the example of how to set up initialize with a hash, but also require first and last name
	def initialize(first_name, last_name, options = {})
		@first_name = first_name
		@last_name = last_name
		@email = options[:email]
		@notes = options[:notes]
		# this line below I like, it's a way to take the instance id from the class variable id, so the
		# class variable keeps incramenting and the @id is taking a value from the current value of @@id
		@id = @@id
		@@id += 1
	end

	def self.create(first_name, last_name, options = {})
		new_contact = new(first_name, last_name, options)
		@@contacts << new_contact
	end

	def self.all
		@@contacts
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def self.find(id)
		@@contacts.each do |contact|
			if contact.id == id
				return contact
			end
		end
		return nil
	end

	def self.update
	end

	def self.delete(id)
		to_delete = find(id)
			@@contacts.delete(@@contacts.index(to_delete))
	end

end