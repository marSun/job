class SearchCrawler
  LAGOU_SEARCH_URL = "http://www.lagou.com/jobs/list_?"

  def self.test_hash
    hash = {
      city: "北京",
      position: "产品经理",
      experience: "1-3年",
      position_type: "全职",
      education: "本科",
      pub_time: "一月内",
      page_no: nil     
    }

  end

  def initialize(hash)
    h = hash.slice(:city, :position, :experience, :position_type, :education, :pub_time, :page_no)
    @condition = {
      city: h[:city],
      gj: h[:experience],
      gx: h[:position_type],
      kd: h[:position],
      labelWords: nil,
      lc: nil,
      pl: nil,
      pn: h[:page_no],
      requestId: nil,
      spc: nil,
      st: h[:pub_time],
      workAddress: nil,
      xl: h[:education], 
      yx: nil
    }
    @url = build_url(@condition)
  end

  def run
    if @crawler.blank?
      @crawler = get_crawler
    end
    p "************scratch page #{@condition[:pn].blank? ? 1 : @condition[:pn]}***************"
    @result = @crawler.get(@url)
  end

  def get_html
    run
    @result[:body]
  end

  #保存到数据库
  def save

  end

  #先采用返回Cobweb实例的方式
  #TODO
  #改写成crawler池的方式
  def get_crawler
    return Cobweb.new
  end

  private
  def build_url(condition)
    str = ""
    condition.each_pair do |key, value|
      if value.blank?
        str += "#{key.to_s}=&"
      else
        str += "#{key.to_s}=#{value.to_s}&"
      end
    end
    return LAGOU_SEARCH_URL + str
  end



end
