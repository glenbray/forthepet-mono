module Admin::CategoryHelper
  def options_for_categories_dropdown categories = Category.hash_tree, options = []
    return @cached_options if @cached_options.present?
    options ||= []
    categories.each do |category, children|
      options << ['– ' * category.depth + category.name, category.id]
      options_for_categories_dropdown(children, options) if children.present?
    end
    options
  end

  def flat_array_from_hash_tree categories = Category.hash_tree, options = []
    options ||= []
    categories.each do |category, children|
      options << category
      flat_array_from_hash_tree(children, options) if children.present?
    end
    options
  end
end
