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
      unless Photo.find_by_source_url(link["href"])
        Photo.new_from_source_url(link["href"])
        puts "Photo created * #{ link['href'] }"
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
      Photo.all.each do |photo|
        unless user.completions.include? photo.source_url
          puts "user id: #{ user.id }"
          photo.save_to_dropbox(user, photo.id, photo.source_url)
          user.completions.push photo.source_url
          user.save!
          puts "#{ user.name }: Photo saved to Dropbox as #{ photo.id }.jpg"
        end
      end
    end
  end
  puts "Done."
end

desc "Upgrade activated users over to the new system"
task upgrade_users: :environment do
  puts "Upgrading users..."
  User.consumers.each do |user|
    unless user.deactivated
      Photo.all.each do |photo|
        user.completions.push photo.source_url
      end
      user.save!
      puts "#{ user.name } has been upgraded."
    end
  end
  puts "Done."
end
