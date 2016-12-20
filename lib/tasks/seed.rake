require 'csv'

namespace :cp do
	namespace :db do

		desc "Seeds the database with seed data necessary for the dev environment"
		task :seedDev => :environment do
			seedUsers
			seedBooks
			seedCampus
		end


		def seedCampus
			puts "Seeding Campus..."
			fileRead = File.new(Dir.pwd + "/db/seed/campus.txt", "r")

			Campus.transaction do
			  while (line = fileRead.gets)
					begin
					  row = line.scan(/(.*)\|(.*)\|(.*)\n/).flatten
					  campus = Campus.create
					  campus.name = row[0]
					  campus.city = row[1]
					  campus.state = row[2]
					  campus.save
					rescue Exception => e
					  puts "Error Occured: #{e.message}"
					end
			  end
			end
		end

		def seedBooks
			puts "Seeding Books..."
			file = "db/seed/dev/books.csv"
			CSV.foreach(file, :headers=> true) do |row|
				Book.create({
				:title => row[1],
				:author => row[2],
				:publisher => row[3],
				:isbn10 => row[4],
				:isbn13 => row[5],
				:pricenew => row[8],
				:priceused => row[9],
				:category => row[10]})
			end
		end

		def seedUsers
			puts "Seeding Users..."
			file = "db/seed/dev/users.csv"
			CSV.foreach(file, :headers=> true) do |row|
				user = User.create
				user.firstname = row[1]
				user.lastname = row[2]
				user.campus_id = row[3]
				user.email = row[4]
				user.email_confirmation = row[4]
				user.password = row[20]
				user.confirmation_token = row[14]
				user.confirmed_at = row[15]
				user.confirmation_sent_at = row[16]

				begin
					user.save!
				rescue Exception => e
					puts e.message
				end
			end
		end

	end
end
