# SeedCampus.rb
# This file will load all of the seed data for the Campus table.
# This script will will first delete all data from the Campus table. It will then read the input file, and add the data into the Campus table. 

fileRead = File.new(Dir.pwd + "/script/SeedDB/SeedCampus/input.txt", "r")

Campus.delete_all

Campus.transaction do
  while (line = fileRead.gets)
	begin
	  row = line.scan(/(.*)\|(.*)\|(.*)\n/).flatten
	  campus = Campus.create
	  campus.name = row[1]
	  campus.state = row[0]
	  campus.type = row[2]
	  campus.save
	rescue Exception => e
	  puts "Error Occured: #{e.message}"
	end
  end
end
