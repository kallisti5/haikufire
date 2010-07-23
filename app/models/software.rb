class Software < ActiveRecord::Base
	#belongs_to :category

	validates_presence_of :title
	validates_presence_of :category_id
	validates_presence_of :author
	validates_presence_of :description
	validates_presence_of :compiled

	validates_uniqueness_of :title

  # run write_file after save to db
  after_save :write_file
  
  # run delete_file method after removal from db
  after_destroy :delete_file
  
  # setter for form file field "cover"
  # grabs the data and sets it to an instance variable.
  # we need this so the model is in db before file save,
  # so we can use the model id as filename.
  def icon=(file_data)
    @file_data = file_data
  end
  
  # write the @file_data data content to disk,
  # using the ALBUM_COVER_STORAGE_PATH constant.
  # saves the file with the filename of the model id
  # together with the file original extension
  def write_file
    if @file_data
      path = "public/repo/#{id}"
      FileUtils.makedirs(path)
      File.open("#{path}/icon.#{extension}", "w") { |file| file.write(@file_data.read) }
      # TODO: IMPORTANT resize image to 32x32 if image is over 32x32
    end
  end
  
  # deletes the file(s) by removing the whole dir
  def delete_file
    FileUtils.rm_rf("public/repo/#{id}")
  end
  
  # just gets the extension of uploaded file
  def extension
    @file_data.original_filename.split(".").last
  end  

end
