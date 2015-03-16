class JobExcuter

  def self.excute
    LagouJobLink.unscratch.each do |link|
      j_c = JobCrawler.new(link.url)
      j_p = JobParser.new(j_c.get_html)
      data = j_p.extract_data
      data[:position_url] = link.url
      data[:position_key] = link.position
      LagouJob.add data
    end
  end

  def self.test(url)
    excute(url)
  end

end
