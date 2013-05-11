require 'spec_helper'

describe MoviesController do
  describe 'searching by the same director' do
    before :each do
      @id = '1'
      @fake_movie = mock('Movie');
      @fake_movie.stub(:title).and_return('Title')
      Movie.stub(:find).with(@id).and_return(@fake_movie)
    end
    it 'should call a model method that performs the search' do
      Movie.should_receive(:same_director).with(@id)
      get :same_director, {:id => @id}
    end
    describe 'after valid search' do
      it 'should select the Similar Director template for rendering' do
        Movie.stub(:same_director)
        get :same_director, {:id => @id}
        response.should render_template('same_director')
      end
    end
    describe 'after invalid search' do
      before :each do
        @message = %q{'Movie' has no director info}
      end
      it 'should select the home page template for rendering' do
        Movie.stub(:same_director).and_raise(Movie::InvalidDirectorError.new(@message))
        get :same_director, {:id => @id}
        response.should redirect_to(movies_path)
      end
      it 'should should render a view with an error message' do
        Movie.stub(:same_director).and_raise(Movie::InvalidDirectorError.new(@message))
        get :same_director, {:id => @id}
        flash[:notice].should eql(@message)
      end
    end
  end
end
