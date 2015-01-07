class Comment < ActiveRecord::Base
  belongs_to :article, dependent: :destroy #when the object is destroyed, destroy will be called on its associated objects.
  validates :rating, inclusion: (1..5)
end
