# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Create Default admin user
User.create( :username => "admin",
             :password => "password",
             :name => "An administrator",
             :email => "kallisti5@unixzen.com",
             :role => 0,
             :created_at => Time.now)

# Create Default Categories
Category.create( :name => "Network",
                 :description => "Local or remote network related applications and utilities.")
Category.create( :name => "Multimedia",
                 :description => "Sound or video related applications.")
Category.create( :name => "Internet",
                 :description => "Applications or utilities relating to the world wide web.")
Category.create( :name => "Development",
                 :description => "Applications or utilities relating to Haiku software development.")
Category.create( :name => "Office",
                 :description => "Document management or business related applications.")
Category.create( :name => "Utilities",
                 :description => "General system utilities")
Category.create( :name => "Engineering",
                 :description => "Engineering utilities.")
Category.create( :name => "Games",
                 :description => "Games for the Haiku operating system.")
Category.create( :name => "Drivers",
                 :description => "Haiku compatible drivers for your system.")
Category.create( :name => "Graphics",
                 :description => "Applications to view or manipulate photos.")
Category.create( :name => "Education",
                 :description => "Education related applications.")

# Create Default arches
Arch.create( :name => "x86", :active => 1 )
Arch.create( :name => "x86_64", :active => 0 )
Arch.create( :name => "PowerPC", :active => 0 )
Arch.create( :name => "ARM", :active => 0 )
Arch.create( :name => "MIPS", :active => 0 )
Arch.create( :name => "MIPSEL", :active => 0 )
Arch.create( :name => "m68k", :active => 0 )
