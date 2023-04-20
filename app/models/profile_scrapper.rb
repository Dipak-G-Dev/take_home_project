class ProfileScrapper < Kimurai::Base
  @name = "profiles_scrapper_spider"
  @engine = :mechanize

  def self.process(url, id)
    @start_urls = [url]

    user_agent_alias "Chrome/68.0.3440.84"
    cookies_policy :all

    before do
      @id = id
    end

    def parse(response, url:, data: {})
      name = response.css('.pv-top-card-section__name').text.strip
      headline = response.css('.pv-top-card-section__headline').text.strip
      location = response.css('.pv-top-card-section__location').text.strip
      summary = response.css('.pv-about__summary-text').text.strip
      experience_items = response.css('.pv-experience-item')

      experiences = experience_items.map do |item|
        title = item.css('.pv-entity__summary-info h3').text.strip
        company_name = item.css('.pv-entity__secondary-title').text.strip
        duration = item.css('.pv-entity__date-range span:nth-child(2)').text.strip
        description = item.css('.pv-entity__description').text.strip

        {
          title: title,
          company_name: company_name,
          duration: duration,
          description: description
        }
      end

      {
        id: @id,
        name: name,
        headline: headline,
        location: location,
        summary: summary,
        experiences: experiences
      }
    end
  end
end
