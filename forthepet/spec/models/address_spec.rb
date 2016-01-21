require 'rails_helper'

describe Address, type: :model do
  it { is_expected.to belong_to :user }
end
