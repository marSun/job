# == Schema Information
#
# Table name: job_links
#
#  id       :integer          not null, primary key
#  url      :string(255)
#  type     :string(255)
#  position :string(255)
#  sign     :integer          default(0)
#

class LagouJobLink < JobLink

  SIGN = {
    unscratched: 0,
    scratched: 1
  }

  scope :unscratch, ->{where(sign: SIGN[:unscratched])}

  class << self
    def add(options)
      create!(options)
    end

    def batch_add(data)
      data[:url].each do |link|
        add(url: link, position: data[:position])
      end
    end
  end

end
