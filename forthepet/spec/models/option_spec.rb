require 'rails_helper'

describe Option, type: :model do

  it 'is invalid without a name' do
    expect(Option.new(name: nil)).to have(1).errors_on(:name)
  end

  it { is_expected.to have_many(:option_values) }
  it { is_expected.to have_and_belong_to_many(:products) }

end
