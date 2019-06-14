class Task < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 700}
  validates :content, presence: true, length: { maximum: 700}
  validates :tag, length: { maximum: 255}
  
  acts_as_taggable

end
