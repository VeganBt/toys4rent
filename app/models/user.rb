class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  has_many :bookings
  has_many :toys
  
  has_one_attached :photo

  # Geocoding
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  after_validation :set_city_and_country

  private

  def set_city_and_country
    results = Geocoder.search(address)
    if results.first
      self.city = results.first.city
      self.country = results.first.country
    end
  end

end
