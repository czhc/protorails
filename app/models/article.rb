class Article < ActiveRecord::Base
  has_many :comments
  validates :title, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if comments.none?
    comments.inject(0) {|sum, comment| sum + comment.rating} / comments.count.to_f
  end
end
