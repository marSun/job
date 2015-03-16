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
