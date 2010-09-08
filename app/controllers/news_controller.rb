class NewsController < ApplicationController

	def index
		# Gather news items from Twitter and prepare them for the view
		gem "twitter4r"
		require 'ostruct'

		begin

		# OAuth is the devil
		# TODO:DEPLOY
		#  * key is token
		#  * secret is secret
		# info below is NOT consumer_xxx, that is in environment.rb
		twitter = Twitter::Client.new( :oauth_access => {
							:key => "XXXX-XXX",
							:secret => "XXX" }) 

		@twitter_timelines = twitter.timeline_for(:user, :id => "haikufire")

		@twitter_timelines.slice!(8,@twitter_timelines.count)	# only show last 8 tweets


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
