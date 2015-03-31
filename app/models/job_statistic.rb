# == Schema Information
#
# Table name: job_statistics
#
#  id         :integer          not null, primary key
#  position   :string(255)
#  count      :integer
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class JobStatistic < ActiveRecord::Base
  attr_accessible :position, :count

end
