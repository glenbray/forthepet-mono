module ApplicationHelper

  def nav_links
    [
      nav_link('All Deals', root_path),
      nav_link('Dog', product_path('dog')),
      nav_link('Cat', cat_deals_products_path),
      nav_link('Misc', misc_deals_products_path),
      nav_link('Refer Friends', referrals_path),
      nav_link('How it works', how_it_works_path),
      nav_link('About', about_path)
    ]
  end

  private

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-active' : ''
    {name: link_text, url: link_path, class: class_name}
  end

end
