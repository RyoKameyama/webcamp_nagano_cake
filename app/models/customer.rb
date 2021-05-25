class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum is_deleted: {Available: false, Invalid: true}
      def active_for_authentication?
        super && (self.is_deleted === "Available")
      end

  has_many :cart_items
  has_many :orders
  has_many :addresses

end
