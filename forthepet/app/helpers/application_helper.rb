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

  def nav_links
    [
      {name: 'All Deals',       url: root_path},
      {name: 'Dog Deals',       url: dog_deals_products_path},
      {name: 'Cat Deals',       url: cat_deals_products_path},
      {name: 'Misc',            url: misc_deals_products_path},
      {name: 'Refer a Friend',  url: referrals_path},
      {name: 'How it works',    url: how_it_works_path},
      {name: 'About',           url: about_path}
    ]
  end

  def nav_link(link_text, link_path, &block)
    class_name = current_page?(link_path) ? 'menu-active' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path, block
    end
  end

end
