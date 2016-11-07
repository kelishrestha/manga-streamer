module PageCrawler
  class << self
    def fetch_data(page_link, keys)
      mechanize = Mechanize.new
      page = mechanize.get(page_link)
      search_response = search(page, keys)
    end

    private

    def search(page, keys)
      search_response = keys.inject({}) do |response, key|
        if response.empty?
          # for single search
          response = page.search(key)
        else
          # for multi search
          # if response is already present,
          # crawl through the previous response
          response = response.search(key)
        end
      end
    end
  end
end
