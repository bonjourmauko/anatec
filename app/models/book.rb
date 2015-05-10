class Book < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :borrower, class_name: 'User'

  validates :title, presence: true
  validates :author, presence: true

  delegate :full_name, to: :borrower, prefix: true, allow_nil: true
  delegate :full_name, to: :owner, prefix: true, allow_nil: true

  scope :lent_books, -> { where.not(borrower: nil) }

  def lend(user)
    return if owner.id == user.id
    return if lent?
    self.borrower = user
    save
  end

  def return
    self.borrower = nil
    save
  end

  def lent?
    borrower.present?
  end
end
