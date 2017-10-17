class Author < ActiveRecord::Base
  validates :phone_number, length: { is: 10 }
  validates :name, presence: true, uniqueness: true
end
