class Message < ActiveRecord::Base
  belongs_to :chatroom
  validates_presence_of :chatroom_id, :user, :message
  validates_numericality_of :chatroom_id
end
