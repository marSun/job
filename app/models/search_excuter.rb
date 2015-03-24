class SearchExcuter

  POSITIONS = %w(产品经理 IOS工程师 Android工程师 PHP工程师 Java工程师 前端工程师)

  def self.excute
    POSITIONS.each do |position|
      get_data({
        position: position
      })
    end 
  end

  def self.get_data(opt)
    hash = {
          city: opt[:city] || "北京",
          position: opt[:position] || "产品经理",
          experience: opt[:experience] || "1-3年",
          position_type: opt[:position_type] || "全职",
          education: opt[:education] || "本科",
          pub_time: opt[:pub_time] || "一月内",
          page_no: nil     
    }
    links = []

    s_c = SearchCrawler.new(hash)
    s_p = SearchParser.new(s_c.get_html)
    links << s_p.extract_data
    opt = s_p.parse_page
    page = Page.new(opt)

    
    while page.has_next_page
      hash[:page_no] = page.next_page
      s_c = SearchCrawler.new(hash)
      s_p = SearchParser.new(s_c.get_html)
      links << s_p.extract_data
      #先只取一页
      break
    end
    links.flatten!
    data = {
      url: links,
      position: hash[:position]
    }
    LagouJobLink.batch_add(data)
  end

end
