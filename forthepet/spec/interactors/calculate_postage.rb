require 'rails_helper'

describe CalculatePostage do
  describe 'calculate' do
    subject { CalculatePostage.new(postcode, weight) }

    context 'postcodes with free postage' do
      let(:weight) { 3 }

      context 'weight less than 4kg' do
      end

      context 'weight greater or equal to 4kg' do
        let(:weight) { 4 }

        (2000..2330).each do |p|
          let(:postcode) { p }

          it 'returns 0' do
            expect(subject.calculate).to eq(0)
          end
        end

      end

    end
  end
end
