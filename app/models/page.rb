class Page

  def initialize(opt)
    @current_page = opt[:current_page]
    @total_page = opt[:total_page]
  end

  def next_page
    @current_page +=1
    return (@current_page > @total_page) ? @total_page : @current_page
  end

  def has_next_page
    return @current_page < @total_page
  end
  
end
