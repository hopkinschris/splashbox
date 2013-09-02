desc "Scrape photo urls from unsplash.com"
task scrape: :environment do
  puts "Scraping photos now..."
  require 'nokogiri'
  require 'open-uri'

  (1..999).each do |i|
    doc = Nokogiri::HTML(open("http://unsplash.com/page/#{ i }"))
    html = doc.css('.post .photo_div a')
    break if html.empty?
    html.each do |link|
      unless Photo.has_source_url?(link["href"])
        Photo.new_from_source_url(link["href"])
        puts "Photo created: #{ Photo.last.source_url }"
      end
    end
  end
  puts "Done."
end

desc "Save photos to Dropbox"
task save_photos: :environment do
  puts "Saving photos to Dropbox..."
  Photo.where(saved_to_dropbox: false).each do |photo|
    Photo.save_to_dropbox(photo.id, photo.source_url)
    puts "Photo saved to Dropbox as #{ photo.id }.jpg"
  end
  puts "Done."
end
