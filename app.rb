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
