require 'rails_helper'

feature "Articles", :type => :feature do
  context 'no articles have been added' do
    scenario 'display a prompt to add an article' do
      visit articles_path
      expect(page).to have_content 'no articles yet'
      expect(page).to have_link 'Add an article'
    end
  end

  context 'articles have been added' do
    before {Article.create title: '15 free things to do in Barcelona'}

    scenario 'display articles' do
      visit articles_path
      expect(page).to have_content '15 free things to do in Barcelona'
      expect(page).not_to have_content 'no articles yet'
    end
  end

  describe 'creating articles' do
    context 'with valid credentials' do
      # before do
      #   user = FactoryGirl.create(:user)
      #   login(user)
      # end

      scenario 'prompts user to fill out a form, then displays the new article' do
        visit articles_path
        click_link 'Add an article'
        fill_in 'Title', with: '15 free things to do in Barcelona'
        click_button 'Create Article'
        expect(page).to have_content '15 free things to do in Barcelona'
        expect(current_path).to eq articles_path
      end

      scenario 'does not let user submit a title that is too short' do
        visit articles_path
        click_link 'Add an article'
        fill_in 'Title', with: 'no'
        click_button 'Create Article'
        expect(page).not_to have_css 'h2', text: 'no'
        # expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing articles' do
    let!(:transsiberia){Article.create(title:'Trans-Siberia')}

    scenario 'lets a user view an article' do
     visit articles_path
     click_link 'Trans-Siberia'
     expect(page).to have_content 'Trans-Siberia'
     expect(current_path).to eq "/articles/#{transsiberia.id}"
    end
  end

  describe 'editing articles' do
    before {Article.create title: 'Trans-Siberia'}

    context 'with valid credentials' do
      scenario 'let a user edit an article' do
       visit articles_path
       click_link 'Edit'
       fill_in 'Title', with: 'Trans-Mongolia'
       click_button 'Update Article'
       expect(page).to have_content 'Trans-Mongolia'
       expect(current_path).to eq articles_path
      end
    end
  end

  describe 'deleting restaurants' do
    before {Article.create title: 'Trans-Siberia'}

    context 'with valid credentials' do
      scenario 'removes an article when a user clicks a delete link' do
        visit articles_path
        click_link 'Delete'
        expect(page).not_to have_content 'Trans-Siberia'
        expect(page).to have_content 'Article deleted successfully'
      end
    end
  end
end