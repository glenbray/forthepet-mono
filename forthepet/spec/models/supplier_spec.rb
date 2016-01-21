require 'rails_helper'

describe Supplier, type: :model do

  it { is_expected.to have_many(:products) }

end
