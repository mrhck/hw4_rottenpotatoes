require 'spec_helper'

describe Movie do
  fixtures :movies
  describe 'searching by the same director' do
    it 'should find movie with same director' do
      id = 1
      baseMovie = Movie.find(id)
      movies = Movie.same_director(id)
      movies.size.should == 1
      movies[0].director.should == baseMovie.director
    end
    it 'should find no movies' do
      id = 3
      movies = Movie.same_director(id)
      movies.size.should == 0
    end
    it 'should raise an exception when director is empty' do
      id = 4
      lambda{Movie.same_director(id)}.should raise_error(Movie::InvalidDirectorError)
    end
  end
end
