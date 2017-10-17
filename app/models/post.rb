class SpamValidator < ActiveModel::Validator
  def validate(post)
    clickbait = ["Won't Believe", "Secret", "Top #{/[0-9]/}", "Guess"]
    if (post.title != nil) && clickbait.none? { |bait| post.title.match(bait) }
      post.errors[:title] << "must include clickbait"
    end
  end
end

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }

  include ActiveModel::Validations
  validates_with SpamValidator
end

# class Post < ActiveRecord::Base
#   validates :title, presence: true
#   validates :content, length: { minimum: 250 }
#   validates :summary, length: { maximum: 250 }
#   validates :category, inclusion: { in: ["Fiction", "Non-Fiction"] }
#   validate :check_clickbait
#
#   def check_clickbait
#     clickbait = ["Won't Believe", "Secret", "Top #{/[0-9]/}", "Guess"]
#     if (self.title != nil) && clickbait.none? { |bait| self.title.match(bait) }
#       errors.add(:title, "must include clickbait")
#     end
#   end
# end
