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
      User.consumers.each do |user|
        unless user.photos.find_by_source_url(link["href"])
          Photo.new_from_source_url(user, link["href"])
          puts "User #{ user.id }: Photo created * #{ link['href'] }"
        end
      end
    end
  end
  puts "Done."
end

desc "Save photos to Dropbox"
task save_photos: :environment do
  puts "Saving photos to Dropbox..."
  User.consumers.each do |user|
    unless user.deactivated
      user.photos.where(saved_to_dropbox: false).each do |photo|
        photo.save_to_dropbox(user, photo.id, photo.source_url)
        puts "User #{ user.id }: Photo saved to Dropbox as #{ photo.id }.jpg"
      end
    end
  end
  puts "Done."
end
