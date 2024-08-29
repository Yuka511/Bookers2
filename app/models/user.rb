class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :books, dependent: :destroy
  has_one_attached :profile_image
  
  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end
  
validates :name, 
  presence: true, 
  length: { minimum: 2, maximum: 20, 
            too_short: "Name is too short (minimum is 2 characters)", 
            too_long: "Name is too long (maximum is 20 characters)" }, 
  uniqueness: true
validates :introduction, length: { maximum: 50 }
end
