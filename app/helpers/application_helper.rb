# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def decode_user_role(role_id)
	role_map = ["Site Administrator", "Super User", "User"]
	return role_map[role_id]
end

def pull_user_role(user_id)
	if (user_id)
		user_data = User.find(:first,:conditions => ["id = ?", user_id])
		return user_data.role
	else
		return 99
	end
end

def pull_recent_software()
	Software.find(:all,:order => "updated DESC", :limit => 10)
end

end
