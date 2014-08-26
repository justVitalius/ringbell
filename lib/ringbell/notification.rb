module RingBell
  class Notification < ActiveRecord::Base
    # For rails < 4
    # attr_accessible :user_id, :user, :changer_id, :changer, :message

    self.table_name = 'ringbell_notifications'

    belongs_to :notifiable, polymorphic: true
    belongs_to :user
    belongs_to :changer, class_name: 'User', foreign_key: 'changer_id'
  end
end