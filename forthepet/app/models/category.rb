class Category < ActiveRecord::Base
  mount_uploader :picture, CategoryUploader

  has_closure_tree

  has_and_belongs_to_many :products
  validates :name, :slug, presence: true
  validate :slug_is_uniq_among_siblings

  scope :not_category_and_descendant, ->category do
    where.not id: category.self_and_descendant_ids
  end

  def selectable?
    parent_id.present? && descendant_ids.blank?
  end

  before_validation { self.slug ||= self.name.to_s.downcase.gsub ' ', '-'}

  private

  def slug_is_uniq_among_siblings
    sibling_with_same_slug = siblings.find_by slug: slug
    if sibling_with_same_slug.present?
      errors.add :slug, 'Category slug must be uniq among siblings'
    end
  end
end
