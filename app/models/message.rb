class Message < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :conversation
  belongs_to :user

  scope :for_display, -> { order(:created_at).last(50) }
end
