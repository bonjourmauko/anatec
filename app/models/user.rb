class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :owned_books,
           class_name: 'Book',
           foreign_key: 'owner_id',
           dependent: :destroy

  has_many :borrowed_books,
           class_name: 'Book',
           foreign_key: 'borrower_id',
           dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :lent_books, to: :owned_books

  scope :without, ->(user) { where.not(id: user) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
