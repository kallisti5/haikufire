class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :name
      t.string :email
      t.integer :role
      t.timestamp :created_at
      t.timestamp :last_login

      t.timestamps
    end

        User.create :login => "admin",
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
