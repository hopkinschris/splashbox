require 'mechanize'

class Photo < ActiveRecord::Base
  extend Splashbox::Dropbox

  attr_accessible :source_url,
                  :saved_to_dropbox

  def self.has_source_url?(url)
    if self.find_by_source_url(url)
      return true
    else
      return false
    end
  end

  def self.new_from_source_url(url)
    self.create(source_url: url)
  end

  def self.save_to_dropbox(id, url)
    agent = Mechanize.new

    # Deal with any redirects (e.g. bit.ly)
    initial_url = agent.get(url)
    destination_url = initial_url.uri.to_s

    content = agent.get_file(destination_url)
    upload_file("#{ id }.jpg", content)
    photo = Photo.find_by_id(id)
    photo.update_attribute(:saved_to_dropbox, true)
  end
end
