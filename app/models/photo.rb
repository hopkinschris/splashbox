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

    if content = agent.get(destination_url)
      image = Base64.encode64 content.body_io.to_s
    end
    upload_file("#{ id }.jpg", image)
    mark_saved_to_disk
  end

  private

  def mark_saved_to_dropbox
    self.saved_to_dropbox = true
    save
  end
end
