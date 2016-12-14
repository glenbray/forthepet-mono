class Brand < ActiveRecord::Base
  has_many :products
  validates :name, presence: true

  scope :by_category, ->category do
    joins(products: :categories)
      .where("categories.id IN (?)", category.self_and_descendant_ids)
      .uniq
  end

  def to_s
    name
  end
end
