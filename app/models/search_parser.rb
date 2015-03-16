class SearchParser

  def initialize(html_string)
    @page = html_string
  end

  def parse
    @doc = Nokogiri::Slop @page
    items = @doc.html.body.div(css: "[id=body]").div(css: "[id=container]").div(css: "[class=content]").ul.li
    @data = []
    items.each do |item|
      @data << item.div(css: "[class=hot_pos_l]").div.a.attribute("href").value
    end
  end

  def parse_page
    @doc ||= Nokogiri::Slop @page
    content = @doc.html.body.div(css: "[id=body]").div(css: "[id=container]").div(css: "[class=content]")
    page_script = content.next_element
    total_page = page_script.content.gsub(/pageCount:\s\d*/).first.split(" ")[1]
    curr_page = page_script.content.gsub(/currPage:\s\d*/).first.split(" ")[1]

    page_opt = {
      current_page: curr_page.to_i,
      total_page: total_page.to_i
    }
  end
  
  def extract_data
    if @data.blank?
      parse
    end

    return @data
  end

end
