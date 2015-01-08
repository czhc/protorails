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

  describe 'validity' do
    it 'is not valid with a title of less than three characters' do
      article = Article.new(title: "kl")
      expect(article).to have(1).error_on(:title)
      expect(article).not_to be_valid
    end

    it "is not valid unless it has a unique title" do
      Article.create(title: "London Bridge ")
      article = Article.new(title: "London Bridge")
      expect(article).to have(1).error_on(:title)
    end
  end
end