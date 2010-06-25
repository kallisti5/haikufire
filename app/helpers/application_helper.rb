# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def decode_user_role(role_id)
	role_map = ["Site Administrator", "Super User", "User"]
	return role_map[role_id]
end

end
