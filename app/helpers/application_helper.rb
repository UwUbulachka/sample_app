module ApplicationHelper
  def full_title(page_title = '')  #full_title(yield(:title))
    base_title = "Ruby on Rails Tutorial Sample App"

    if page_title.empty? #если заколовок страницы пуст выводи только base title
        base_title
    else #иначе выводи заголовк станицы и основной заголовок
       "#{page_title} | #{base_title}"  
    end    
  end
end
