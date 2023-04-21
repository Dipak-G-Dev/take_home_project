class ProfileScrapper < Kimurai::Base
  @name = "profile_scraper"
  @engine = :selenium_chrome
  attr_accessor :data
  def self.process(url)
    @config = {
      user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36",
      options: Selenium::WebDriver::Chrome::Options.new(args: %w[headless disable-gpu]),
      driver_path: '/path/to/chromedriver'
      }
    @start_urls = [url]

    self.parse!(:parse, url: url)
  end

  def parse(response, url:, data: {})
    name = response.css("li.inline.t-24.t-black.t-normal.break-words").text.strip rescue nil
    headline = response.css("h2.mt1.t-18.t-black.t-normal.break-words").text.strip rescue nil
    location = response.css("li.t-16.t-black.t-normal.inline-block").text.strip rescue nil
    connections = response.css("li.inline.t-16.t-black.t-normal").text.strip.split("\n").first rescue nil
    summary = response.css("section.pv-about-section .pv-about__summary-text.mt4.mb5").text.strip rescue nil
    experience = []
    response.css("section#experience-section ul li").each do |exp|
      title = exp.css("h3.t-16").text.strip rescue nil
      company = exp.css("p.t-16.t-black.t-normal.inline-block").text.strip rescue nil
      duration = exp.css("span.pv-entity__bullet-item-v2").text.strip rescue nil
      experience << { title: title, company: company, duration: duration }
    end
    education = []
    response.css("section#education-section ul li").each do |edu|
      degree = edu.css("h3.t-16").text.strip rescue nil
      major = edu.css("span.pv-entity__comma-item").text.strip rescue nil
      school = edu.css("p.pv-entity__secondary-title").text.strip rescue nil
      duration = edu.css("span.pv-entity__dates").text.strip rescue nil
      education << { degree: degree, major: major, school: school, duration: duration }
    end
    @data = {
      name: name,
      headline: headline,
      location: location,
      connections: connections,
      summary: summary,
      experience: experience,
      education: education
    }
    save_to "#{Rails.root}/tmp/#{Time.now.to_i}_linkedin_profile.json", data: data, format: :pretty_json
  end

  def self.visit_profile(url, driver)
    driver.visit(url)
    sleep(2)
    html = driver.html
    data = parse(html, url: url)
  end

  def self.scrape(url)
    # Set custom headers
    headers = {
      "User-Agent" => ENV.fetch("USER_AGENT")
    }
    # Use selenium_chrome as an engine
    response = browser.visit(url, headers: headers)

    # Check if the page is loaded correctly
    if response.status == 200
      # Parse response using parse method
      parse(response, url:url)
    else
      # Log an error and exit the process
      Rails.logger.error("Failed to load the page with status: #{response.status}")
      exit 1
    end
  end
end
