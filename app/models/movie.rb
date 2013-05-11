class Movie < ActiveRecord::Base

  class Movie::InvalidDirectorError < StandardError ; end
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.same_director(id)
    movie=Movie.find(id)
    director=movie.director
    
    if director.to_s.empty?
      raise Movie::InvalidDirectorError, %Q{'#{movie.title}' has no director info}
    end
    
    movies=Movie.where("director = ? AND id != ?", director, id)
  end
end
