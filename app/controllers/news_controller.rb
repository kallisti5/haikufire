class NewsController < ApplicationController

	  # GET /news
	  # GET /news.xml
	def index

		gem "twitter4r"
		require 'ostruct'

		begin
		twitter = Twitter::Client.new(:login => "haikufire", :password => "PASS")
		@twitter_timelines = twitter.timeline_for(:user, :id => "haikufire")

		rescue
			@twitter_timelines = Array.new
			@twitter_timelines << OpenStruct.new(:text => "Twitter news items are currenty offline")
		end


		respond_to do |format|
			format.html # index.html.erb
		end
	end
end
