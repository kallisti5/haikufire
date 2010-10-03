require 'find'
require 'pp'

namespace :db do

	desc "Backup the database to a file. Options: RAILS_ENV=production" 
	task :backup => [:environment] do
		datestamp = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
		backup_base = File.join('db', 'backup')
		backup_folder = File.join(backup_base, datestamp)
		backup_file = File.join(backup_folder, "#{RAILS_ENV}_dump.sql.gz")
		FileUtils.makedirs(backup_folder)
		puts backup_file
		db_config = ActiveRecord::Base.configurations[RAILS_ENV]
		system "mysqldump -u #{db_config['username']} -p#{db_config['password']} -Q --add-drop-table --add-locks=FALSE --lock-tables=FALSE #{db_config['database']} | gzip -c > #{backup_file}"
		if $? != 0
			puts "error building backup, canceling"
			exit 1
		end
		puts "Created backup: #{backup_file}"
	end

	desc "Import a CSV of software items to the database"
	task :import => [:environment] do
		# Export SQL from Haikufire version 1
		# SELECT categories.name as category, software.name, software.created, software.updated, software.author, software.version, software.description, software.url, software.license FROM software LEFT JOIN categories ON software.CATID = categories.ID
		require 'csv'
		@parsed_file=CSV::Reader.parse(params[:dump][:file])
		n=0
		@parsed_file.each  do |row|
			c=CustomerInformation.new
			c.job_title=row[1]
			c.first_name=row[2]
			c.last_name=row[3]
			if c.save
				n=n+1
				GC.start if n%50==0
			end
			puts "CSV import great success! #{n} new software items added to data base."
		end
	end
end
