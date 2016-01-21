require 'rails_helper'

describe Category, type: :model do
  it { is_expected.to have_many(:products) }
end
