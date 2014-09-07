class Photo < ActiveRecord::Base
  include Splashbox::Dropbox
  include Splashbox::Embedly

  serialize :colors, Array

  attr_accessible :source_url,
                  :author_name,
                  :author_url,
                  :colors,
                  :tumblr_url

  def self.new_from_scraper source_url, tumblr_url, author_name, author_url
    Photo.create source_url: source_url, tumblr_url: tumblr_url, author_name: author_name, author_url: author_url
  end

  def save_to_dropbox user, id, url
    agent = Mechanize.new

    # Deal with any redirects (e.g. bit.ly)
    initial_url = agent.get(url)
    destination_url = initial_url.uri.to_s

    content = agent.get_file(destination_url)
    upload_file(user, "#{ id }.jpg", content)
  end

  def color_data_extraction tumblr_url
    extract_colors tumblr_url
  end
end
