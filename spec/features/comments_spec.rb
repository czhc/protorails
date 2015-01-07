require 'rails_helper'

feature "Comments", :type => :feature do
  before {Article.create title: '10 things to do in London for under £10'}

  scenario 'allows users to leave a comment using a form' do
    leave_review('Poor', '2')
    # expect(current_path).to eq articles_path
    expect(page).to have_content 'Poor (2)'
  end

  context 'calculates average ratings' do
    scenario 'displays the average rating' do
      leave_review('Great', '4')
      leave_review('Poor', '2')
      expect(page).to have_content 'Average Rating: ★★★☆☆'
    end
  end
end

#helper method to make the test prettier
def leave_review(thoughts, rating)
  visit articles_path
  click_link 'Comment'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Comment'
end