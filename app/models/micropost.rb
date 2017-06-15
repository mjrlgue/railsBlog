class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  #image upload
  mount_uploader :picture, PictureUploader
  #video upload
  mount_uploader :video, VideoUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  #size of the picture
  validate :picture_size

  private
  #validate picture size
  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, "Picture should be less than 2Mb")
    end
  end
end
