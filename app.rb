get '/' do
  haml :index
end

# List all manga of a site
post '/search/sites/' do
	mechanize = Mechanize.new
	page = mechanize.get('http://mangafox.me/manga/')
	# Search for corresponding div in the site
	page_lists = page.search('.manga_list')
	link_lists = page_lists.search('li').search('a')
	# Accumulating manga titles and links in a hash
	@title_lists = link_lists.inject([]) do |lists, title_link|
		title_hash = {}
		title_hash['title'] = title_link.text.strip
		title_hash['link'] = title_link.attribute('href').value
		lists << title_hash
	end

	haml :_list
end

# List manga chapters
post '/manga/:name/chapters' do
	name = params['name']
	page_link = params['page_link']
	mechanize = Mechanize.new
	page = mechanize.get(page_link)
	chapters = page.search('.tips')
	@chapters = chapters.inject([]) do |lists, page_link|
		title_hash = {}
		title_hash['title'] = page_link.text.strip
		title_hash['link'] = page_link.attribute('href').value

		lists << title_hash
	end
	# Search for image link and traverse with next image links
	chapter_page = mechanize.get(chapter)
	image = chapter_page.search('.image')
	next_image_page = chapter_page.link_with(text: 'next page').click
end
