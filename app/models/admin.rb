class Admin < ApplicationRecord
  MASTER = 16
  NEWS = 8
  RESULTS = 4
  PICKUP_REQUESTS = 2
  APPOINTMENTS = 1
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :post_images
  has_many :users
  belongs_to :lab

  # Validations
  validates :name, presence: true, length: {in: 3..150}
  validates :bio, length: {maximum: 500}
  validates :permissions, numericality: {only_integer: true}
  mount_uploader :photo, ImageUploader
  validates_presence_of :lab


  def self.create_admin_with_random_pass(admin_params)
    adm = Admin.new(admin_params)
    generated_password = Devise.friendly_token.first(8)
    adm.password = generated_password
    adm.password_confirmation = generated_password
    adm
  end

  def regenerate_password
    generated_password = Devise.friendly_token.first(8)
    self.password = generated_password
    self.password_confirmation = generated_password
    save
  end

  def get_processed_permissions
    admin_permissions(self)
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  include AdminHelper
end
