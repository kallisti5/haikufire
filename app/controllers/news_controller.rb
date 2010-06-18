class NewsController < ApplicationController

	def index
		# Gather news items from Twitter and prepare them for the view
		gem "twitter4r"
		require 'ostruct'

		begin
		twitter = Twitter::Client.new(:login => "haikufire", :password => "PASS")
		@twitter_timelines = twitter.timeline_for(:user, :id => "haikufire")

		rescue
			# If there is a problem, create a failure news item.
			# This prevents rails traces based on Twitter Failwhales

			@twitter_timelines = Array.new
			@twitter_timelines << OpenStruct.new(	:text => "Twitter is currently unavailable",
								:created_at => Time.now.asctime << " CST",
								:user => OpenStruct.new(:screen_name => "Failwhale"))
		end


		respond_to do |format|
			format.html # index.html.erb
		end

	end
end
