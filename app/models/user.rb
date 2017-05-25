class User < ApplicationRecord
  EPS = 0
  IPS = 1
  PARTICULAR = 2
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  has_many :results
  has_many :pickup_requests
  has_many :appointments
  belongs_to :admin

  validates :name, presence: true, length: {in: 3..250}
  validates :lastname, length: {in: 3..250}, allow_blank: true
  validates :city, presence: true, length: {in: 3..200}
  validates :doc, presence: true, length: {in: 7..15}
  validates :address, presence: true, length: {in: 10..250}
  validates :phone, presence: true, length: {in: 7..10}
  validates :user_type, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2}

  def self.create_user_with_random_pass(user_params)
    user = User.new(user_params)
    generated_password = Devise.friendly_token.first(8)
    user.password = generated_password
    user.password_confirmation = generated_password
    result = user.save
    UserMailer.welcome_mail(user, user.password).deliver_later if result
    user
  end

  def type_string
    if user_type == 0
      'EPS'
    elsif user_type == 1
      'IPS'
    elsif user_type == 2
      'PARTICULAR'
    end
  end

  def complete_name
    if !self.lastname.nil?
      "#{self.name} #{self.lastname}"
    else
      "#{self.name}"
    end
  end

  def regenerate_password
    generated_password = Devise.friendly_token.first(8)
    self.password = generated_password
    self.password_confirmation = generated_password
    save
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
