require 'rails_helper'

describe Category, type: :model do
  it { is_expected.to have_and_belong_to_many(:products) }
  it { is_expected.to have_and_belong_to_many(:taxons) }
end
