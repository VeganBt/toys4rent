class Toy < ApplicationRecord
  CATEGORIES = %w[Action\ figures
                  Arts\ and\ Crafts
                  Books
                  Building\ &\ Construction
                  Collectable
                  Costumes
                  Dolls
                  Educational
                  Games\ &\ Puzzles
                  Infant\ Toys
                  Miscellaneous
                  Music
                  Plush
                  Ride\ Ons
                  Sports
                  Vehicles
                ]

  belongs_to :user
  has_one_attached :photo
  has_many :bookings, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :category, presence: true, inclusion: { in: CATEGORIES }

end
