require "spec_helper"

describe Link do

  feature 'viewing links' do
    scenario 'so I can see existing links on the home page' do
      Link.create(url: 'https://www.viewinglinks.com', name: 'Viewing Links Test')

      visit '/links'
      expect(page.status_code).to eq 200

      within 'ul#links' do
        expect(page).to have_content('Viewing Links Test')
      end
    end

    feature 'adding links' do
      scenario 'when I add a link on /links/new it will show up in my book marks' do

        visit '/links/new'
        fill_in("name", :with => "Adding Links Test")
        fill_in("url", :with => 'https://www.addinglinks.com')
        click_button('Add Bookmark')

        within 'ul#links' do
          expect(page).to have_content('https://www.addinglinks.com')

        end
      end
    end
  end
end