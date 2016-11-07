module FormatResponse
  class << self
    def format_data(data)
      result = data.inject([]) do |lists, page_link|
        title_hash = {}
        title_hash['title'] = page_link.text.strip
        title_hash['link'] = page_link.attribute('href').value
        lists << title_hash
      end
    end
  end
end
