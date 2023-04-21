class ProfileScrappersController < ApplicationController
  def new
    # Render the form to enter the LinkedIn profile URL
  end

  def create
    url = params[:url]

    if url.present?
      @data = ProfileScrapper.process(url)
    # Store the crawled data in an instance variable to be used in the view
     @data = data
    end
    render 'show'
  end

  def show
    # Render the crawled data in the view
  end

  def scrape
    url = params[:url]

    if url.present?
      data = ProfileScrapper.process(url)
      render json: data
    else
      render json: { error: "URL parameter is required" }, status: :bad_request
    end
  end
end
