# == Schema Information
#
# Table name: hooks
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  bike_id    :integer
#

class Hook < ActiveRecord::Base
  extend FriendlyId
  friendly_id :number

  attr_accessible :number

  validates_presence_of :number
  validates_uniqueness_of :number

  belongs_to :bike, :inverse_of=>:hook

  scope :available, :conditions => {:bike_id => nil}

  # May want to select available condinionally on the bike
  # or bike relations, like projects
  # For example, FFS projects may have a certain set of 
  # hooks reserved only for FFS.
  def self.next_available(bike=nil)
    return Hook.find_by_bike_id(nil)
  end
end
