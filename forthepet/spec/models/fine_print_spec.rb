require 'rails_helper'

describe FinePrint, type: :model do
  it { is_expected.to have_and_belong_to_many :deals }
end
