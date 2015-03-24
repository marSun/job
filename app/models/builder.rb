class Builder

  def self.build
    SearchExcuter.excute
    JobExcuter.excute
    LagouJobStatistic.calculate
  end

end
