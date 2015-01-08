require 'rails_helper'

RSpec.describe Article, :type => :model do
  describe '#average_rating' do
    let(:london) { Article.create title: 'London Olympic 2012' }

    it 'returns N/A if there are no comments' do
      expect(london.average_rating).to eq 'N/A'
    end

    context 'with 1 comment' do
      it 'returns the rating of that comment' do
        london.comments.create(rating: 3)
        expect(london.average_rating).to eq 3
      end
    end

    context 'with multiple comments' do
      it 'returns the average of those comment' do
        london.comments.create(rating: 2)
        london.comments.create(rating: 4)
        expect(london.average_rating).to eq 3
      end
    end

    context 'average comment is not a whole number' do
      it 'returns the average as a float' do
        london.comments.create(rating: 2)
        london.comments.create(rating: 3)
        expect(london.average_rating).to eq 2.5
      end
    end
  end

  describe 'validations' do
    subject { FactoryGirl.create(:article) }
    it { should ensure_length_of(:title).is_at_least(3) }
    it { should validate_uniqueness_of(:title) }
  end
end