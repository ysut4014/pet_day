# app/lib/custom_renderer.rb
class CustomRenderer < WillPaginate::ActionView::LinkRenderer
  protected

  def html_container(html)
    tag(:nav, tag(:ul, html, class: 'pagination'), container_attributes)
  end

  def page_number(page)
    if page == current_page
      tag(:li, link(page, page, rel: rel_value(page)), class: 'page-item active')
    else
      tag(:li, link(page, page, rel: rel_value(page)), class: 'page-item')
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page, class: classname), class: 'page-item')
    else
      tag(:li, tag(:span, text), class: 'page-item disabled')
    end
  end

  def gap
    tag(:li, link(super, '#'), class: 'page-item disabled')
  end
end
