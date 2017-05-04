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

    feature 'adding tags to links' do
      scenario 'when I add a tag to a new link, it gets added to the database with tag' do

        visit '/links/new'
        fill_in("name", :with => "Adding Tag Test")
        fill_in("tags", :with => 'TestTag')
        fill_in("url", :with => 'https://www.adding_tags.com')
        click_button('Add Bookmark')

        visit '/tags/TestTag'
          expect(page).to have_content('https://www.adding_tags.com')
      end
    end

  feature 'filtering by tags' do
    scenario 'when I filter by tags, only links with a specific tag show up' do
      # make_bubble_links
      # make_test_links

      visit '/links/new'
      fill_in("name", :with => "Adding Tag Test")
      fill_in("tags", :with => 'TestTag')
      fill_in("url", :with => 'https://www.adding_tags.com')
      click_button('Add Bookmark')

      visit '/tags/TestTag'

      expect(page).to_not have_content('bubbles')
      expect(page).to have_content('https://www.adding_tags.com')
    end
  end

  feature 'adding multiple tags to a link' do
    scenario 'when I add more than one tag to a link, I want to be able to find that link under all those tags' do

      visit 'links/new'

      visit '/links/new'
      fill_in("name", :with => "Adding Tag Test")
      fill_in("tags", :with => "bubbles, balloons")
      fill_in("url", :with => 'https://www.adding_tags.com')
      click_button('Add Bookmark')

      visit '/tags/bubbles'
      expect(page).to have_content('https://www.adding_tags.com')

      visit '/tags/balloons'
      expect(page).to have_content('https://www.adding_tags.com')
    end
  end
end
