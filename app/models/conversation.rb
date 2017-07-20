class Conversation < ApplicationRecord
  belongs_to :trip

  has_many :messages, dependent: :destroy
  has_many :users, through: :messages

end
