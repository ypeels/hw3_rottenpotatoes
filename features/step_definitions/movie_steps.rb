# Add a declarative step here for populating the DB with movies.
# gah? does this refer to the stuff below?

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element [movie, right?] will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    # Homework 3-1. yes, it really is a one-line problem (but also need bundle exec rake db:test:prepare)
    Movie.create!(movie) # cf. MoviesController#create()
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  
  # Homework 3-3
  # http://rubydoc.info/github/jnicklas/capybara/master/Capybara/Session
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string. [actually it's page.body]
  #page.all('table#movies tbody tr')
  
  #flunk "#{page.content}"
  #flunk "#{page.body}"
  unless page.body.index(e1) < page.body.index(e2)
    flunk "out of order"
  end
  
  # flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |un, rating_list|
  
  # Homework 3-2
  # http://www.ruby-doc.org/core-1.9.3/String.html#method-i-split
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(%r{,\s*}).each do |rating|
    step "I #{un}check \"ratings_#{rating}\""
  end  
  
end

# Homework 3-2 "all ratings selected"
Then /I should see all of the movies/ do

  # http://stackoverflow.com/questions/2986250/how-to-assert-on-number-of-html-table-rows-in-ruby-using-capybara-cucumber
  #page.all('table#movies tr').count.should == Movie.all.length
  if page.all('table#movies tbody tr').count != Movie.all.length
    flunk "movie count #{page.all('table#movies tr').count} - expected #{Movie.all.length}"
    
    # could not figure out how to get their "should" syntax to work
  end

end



