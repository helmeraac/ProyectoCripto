class Result < ApplicationRecord
  belongs_to :user
  belongs_to :lab
  
  validates_presence_of :user
  validates_presence_of :lab
  validates :name, presence: true, length: { in: 3..150 }
  validates :upload_date, presence: true,date:{before: Proc.new { Time.now + 5.seconds }}
  validates :file_path, presence: true
  mount_uploader :file_path , PDFFileUploader

  scope :for_user, ->(user_id) { where("user_id = ?", user_id).order("upload_date DESC") }
end
