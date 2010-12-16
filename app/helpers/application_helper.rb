module ApplicationHelper

def decode_user_role(role_id)
        role_map = ["Site Administrator", "Super User", "User"]
        return role_map[role_id]
end

def pull_recent_software()
        Software.find(:all,:order => "updated DESC", :limit => 10)
end


end
