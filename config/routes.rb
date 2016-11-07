module MangaStreamer
  module MangaRoutes
    extend Sinatra::Extension
    extend ::PageCrawler
    extend ::FormatResponse
    set :haml, format: :html5

    get '/' do
      haml :index
    end

    # List manga chapters
    post '/manga/:name/chapters' do
      name = params['name']
      page_link = params['page_link']
      raw_chapters = PageCrawler.fetch_data(page_link, ['.tips'])
      @chapters = FormatResponse.format_data(raw_chapters)
      haml :_search
      # redirect to('/bar')
      # Search for image link and traverse with next image links
      # chapter_page = mechanize.get(chapter)
      # image = chapter_page.search('.image')
      # next_image_page = chapter_page.link_with(text: 'next page').click
    end

    # Traverse between chapters
    get '/manga/:name/chapters' do
      name = params['name']
      chapter_num = params['num']
      chapter_link = params['chp_link']
      raw_chapters = PageCrawler.fetch_data(chapter_link, ['.image'])

      next_image_page = raw_chapters.link_with(text: 'next page').click
    end

    # List all manga of a site
    post '/search/sites/' do
      page_link = 'http://mangafox.me/manga/'
      raw_chapters = PageCrawler.fetch_data(page_link, ['.manga_list', 'li', 'a'])
      @chapters = FormatResponse.format_data(raw_chapters)
      haml :_list
    end
  end
end
