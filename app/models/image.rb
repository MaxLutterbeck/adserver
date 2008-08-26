class Image < ActiveRecord::Base
  
  belongs_to :image_ad
  
  has_attachment  :content_type => :image,
                  :storage => :file_system,
                  :max_size => 500.kilobytes,
                  :thumbnails => {:thumb => '150x150'},
                  :processor => 'MiniMagick'
  
  validates_as_attachment
  
  def full_filename(thumbnail = nil)
      file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix].to_s
      File.join(RAILS_ROOT, file_system_path, thumbnail_name_for(thumbnail))
  end
    
end
