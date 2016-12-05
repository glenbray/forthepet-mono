class Category < ActiveRecord::Base
  has_closure_tree

  has_and_belongs_to_many :products
  validates :name, presence: true

  scope :not_category_and_descendant, ->category do
    where.not id: category.self_and_descendant_ids
  end

  def selectable?
    parent_id.present? && descendant_ids.blank?
  end
end
