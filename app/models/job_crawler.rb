class JobCrawler
  
  def initialize(job_url)
    @url = job_url
  end

  def run
    if @crawler.blank?
      @crawler = get_crawler
    end
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

end
