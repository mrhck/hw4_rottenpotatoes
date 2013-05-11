# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(:title => movie["title"], :rating => movie["rating"], :director => movie["director"], :release_date => movie["release_date"])
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp
end

Then /^I should( not)? see movies: (.*)/ do |not_see, movie_list|
	movies=movie_list.split(/,\s*/x)
	movies.each do |movie|
		if not_see then
			steps %Q{
						Then I should not see /#{movie}/
					}
		else
			steps %Q{
						Then I should see /#{movie}/
					}
		end
	end
end

Then /^I sould see movies in order: (.*)/ do |movie_list|
	movies=Array.new
  movies=movie_list.split(/,\s*/x)
  for i in (0..(movies.length() -2)) do
  	steps %Q{
						Then I should see "#{movies[i]}" before "#{movies[i+1]}"
					}
  end
end

Then /^the director of "(.*)" should be "(.*)"$/ do |movie, director|
  regexp = /Director:.*#{director}/m
  page.body.should =~ regexp
end




# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
	ratings = rating_list.split(/,\s*/x)
	ratings.each do |rating|
		if uncheck then
			steps %Q{
					When I uncheck "ratings_#{rating}"
				}
		else
			steps %Q{
					When I check "ratings_#{rating}"
				}
		end
	end	
end


