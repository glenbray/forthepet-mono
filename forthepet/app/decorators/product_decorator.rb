class ProductDecorator < BaseDecorator
  def short_description
    description = object.description
    sanitized = ActionView::Base.full_sanitizer.sanitize(description)
    h.truncate(sanitized, length: 150, omission: '...')
  end
end
