class ArticlesController < ApplicationController
  def index
    section = "technology"
    time_period = "1" # 1,7,30
    uri = URI("https://api.nytimes.com/svc/mostpopular/v2/mostshared/#{section}/#{time_period}.json")

    begin
      @resp = Faraday.get uri do |req|
        req.params['api_key'] = ENV['NY_TIMES_MOST_POPULAR_API_KEY']
        req.options.timeout = 10
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @results = body["results"]
        
        # create articles
        @results.each do |result|
          Article.find_or_create_by(title: result["title"], abstract: result["abstract"], date: result["published_date"])
        end

        @articles = Article.limit(body["num_results"])

      else
        @error = body["errors"]
      end
 
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'index'
  end

  def show
    @article = Article.find_by(id: params[:id])
    if @article.nil?
      not_found
    end

    @comment = Comment.new
  end
end
