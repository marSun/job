class JobParser

  def initialize(html_string)
    @page = html_string
  end

  def parse
    @doc = Nokogiri::Slop @page
    item = @doc.html.body.div(css: "[id=body]").div(css: "[id=container]").div(css: "[class=clearfix]").div.first.dl(css: "[class=job_detail]")
    detail = item.dd(css: "[class=job_request]")

    position = item.dt.h1.children.last.content.strip
    spans = detail.span
    time = detail.div.content.strip

    @data = {
      campany: item.dt.h1.div.content.strip,
      position: position,
      salary: spans[0].content.strip,
      city: spans[1].content.strip,
      experience: spans[2].content.strip,
      education: spans[3].content.strip,
      position_type: spans[4].content.strip,
      sub_detail: detail.br.next.content.strip,
      pub_time: time
    }
    
  end
  
  def extract_data
    if @data.blank?
      parse
    end

    return @data
  end

end
