class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username	# user login
      t.string :password	# md5 of user password
      t.string :name		# user real name
      t.string :email		# user email
      t.integer :role		# user role, 0=site admin, 1=super admin, 2=user, 99=unvalidated
      t.timestamp :created_at	# user join date
      t.timestamp :last_login	# user last login
      t.string :validation_hash	# validation hash used for new user registration

      t.timestamps
    end

        User.create :username => "admin",
                    :password => "password",  #why yes.. this is the md5 for 'password'
                    :name => "An administrator",
                    :email => "kallisti5@unixzen.com",
                    :role => 0,
                    :created_at => Time.now
  end

  def self.down
    drop_table :users
  end
end
