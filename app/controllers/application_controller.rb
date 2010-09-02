class ApplicationController < ActionController::Base
  include SimpleCaptcha::ControllerHelpers
  protect_from_forgery

  helper :all # include all helpers, all the time
  helper_method :pull_user_role, :randomhash

  def randomhash( len )
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      return newpass
  end

  def pull_user_role(user_id)
          if (user_id)
                  user_data = User.find(:first,:conditions => ["id = ?", user_id])
                  return user_data.role
          else
                  return 99
          end
  end
end
