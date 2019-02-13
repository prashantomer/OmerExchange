class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :timeoutable, :confirmable, :lockable,
         :omniauthable, omniauth_providers: %i[facebook github]
  
  after_initialize do
    next unless uid.blank?
    begin
      self.uid = "UID#{SecureRandom.hex(5).upcase}"
    end while self.class.where(uid: uid).any?
  end

  validates :email, uniqueness: true, presence: true
  validates :uid, uniqueness: true, presence: true

  class << self
    def from_omniauth(auth)
      where(oauth_provider: auth.provider, oauth_uid: auth.uid).first_or_create do |member|
        member.email = auth.info.email
        member.password = Devise.friendly_token[0, 20]
        # member.name = auth.info.name   # assuming the member model has a name
        # member.image = auth.info.image # assuming the member model has an image
        # If you are using confirmable and the provider(s) you use validate emails, 
        # uncomment the line below to skip the confirmation emails.
        # member.skip_confirmation!
      end
    end
  end
end
