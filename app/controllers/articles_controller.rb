class ArticlesController < ApplicationController
  def search
    section = "technology"
    time_period = "7" # 1,7,30
    uri = URI("https://api.nytimes.com/svc/mostpopular/v2/mostshared/#{section}/#{time_period}.json")

    begin
      @resp = Faraday.get uri do |req|
        req.params['api_key'] = ENV['NY_TIMES_MOST_POPULAR_API_KEY']
        req.options.timeout = 10
      end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @results = body["results"]
      else
        @error = body["errors"]
      end
 
    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
    end
    render 'search'
  end
end
