desc "Scrape photo urls from unsplash.com"
task scrape: :environment do
  puts "Scraping photos now..."
  scraper = Scraper.new
  scraper.run
  puts "Done."
end

desc "Save photos to Dropbox"
task save_photos: :environment do
  puts "Saving photos to Dropbox..."
  User.consumers.find_each do |user|
    Photo.find_each do |photo|
      unless user.completions.include?(photo.source_url)
        puts "user id: #{ user.id }"
        photo.save_to_dropbox(user, photo.id, photo.source_url)
        user.completions.push photo.source_url
        user.save!
        puts "#{ user.name }: Photo saved to Dropbox as #{ photo.id }.jpg"
      end
    end
  end
  puts "Done."
end

# Embed.ly allows for 5000 urls per month for free
desc "Extract color data for existing Photos"
task extract_colors: :environment do
  puts "Extracting color data..."
  Photo.find_each do |photo|
    if photo.colors.empty?
      if colors = Splashbox::Embedly.extract_colors(photo.tumblr_url)
        photo.update_attributes! colors: colors
        puts "Colors updated * #{ photo.id }.jpg"
      end
    end
  end
  puts "Done."
end

# Data Backfillers
desc "Save author name and url for existing Photos"
task save_authors: :environment do
  puts "Saving author details..."
  scraper = Scraper.new
  scraper.get_author_data
  puts "Done."
end

desc "Save tumblr url for existing Photos"
task save_tumblr_urls: :environment do
  puts "Saving tumblr urls..."
  scraper = Scraper.new
  scraper.get_tumblr_urls
  puts "Done."
end
