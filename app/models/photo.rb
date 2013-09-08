class Photo < ActiveRecord::Base
  include Splashbox::Dropbox

  belongs_to :user

  attr_accessible :source_url,
                  :saved_to_dropbox

  def self.new_from_source_url(user, url)
    user.photos.build(source_url: url)
    user.save
  end

  def save_to_dropbox(user, id, url)
    agent = Mechanize.new

    # Deal with any redirects (e.g. bit.ly)
    initial_url = agent.get(url)
    destination_url = initial_url.uri.to_s

    content = agent.get_file(destination_url)
    upload_file(user, "#{ id }.jpg", content)
    self.update_attribute!(:saved_to_dropbox, true)
  end
end
