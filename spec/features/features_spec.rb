require "spec_helper"
require "database_cleaner"
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

describe Link do

  feature 'viewing links' do
    scenario 'so I can see existing links on the home page' do
      Link.create(url: 'https://www.makersacademy.com', name: 'Makers Academy')

      visit '/links'
      expect(page.status_code).to eq 200

      within 'ul#links' do
        expect(page).to have_content('Makers Academy')
      end
    end

    feature 'adding links' do
      scenario 'when I add a link on /links/new it will show up in my book marks' do

        visit '/links/new'
        fill_in("name", :with => "People")
        fill_in("url", :with => 'https://www.people.com')
        click_button('Add Bookmark')

        within 'ul#links' do
          expect(page).to have_content('https://www.people.com')

        end
      end
    end
  end
end
