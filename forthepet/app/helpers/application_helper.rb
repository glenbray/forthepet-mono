module ApplicationHelper
  def is_active?(page_name, controller)
    active = false
    if params[:controller] == controller
      active = true
    end
    if controller == 'static_pages' && params[:action] != page_name
      active = false
    end
    'active' if active
  end

  def nav_link(link_text, link_path, &block)
    class_name = current_page?(link_path) ? 'menu-active' : ''

    content_tag(:li, :class => class_name, 'data-turbolinks' => "false") do
      link_to link_text, link_path, block
    end
  end
end
