def make_test_links
  visit '/links/new'
  fill_in("name", :with => "Adding Tag Test")
  fill_in("tag", :with => 'TestTag')
  fill_in("url", :with => 'https://www.adding_tags.com')
  click_button('Add Bookmark')
end

def make_bubble_links
  visit '/links/new'
  fill_in("name", :with => "BubbleTagTest")
  fill_in("tag", :with => 'bubbles')
  fill_in("url", :with => 'https://www.BubblebubblesBUBBLES.com')
  click_button('Add Bookmark')
end
