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

class LagouJobStatistic < JobStatistic

  #column-------------------------type----------------------description
  #id                             integer                   唯一标志
  #position                       string                    职位名称
  #count                          integer                   职位数量
  #created_at                     datetime                  创建时间
  #updated_at                     datetime                  更新时间
  #-------------------------------------------------------------------

  def self.calculate
    jobs = LagouJob.find_by_sql("select position_key, COUNT(*) as count from lagou_jobs group by position_key")
    jobs.each do |job|
      create!(position: job.position_key, count: job.count)
    end
  end


end
