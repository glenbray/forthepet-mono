require 'rails_helper'

RSpec.describe Feature, type: :model do
  it { is_expected.to belong_to :product }
end
