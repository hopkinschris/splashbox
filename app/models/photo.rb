require 'mechanize'

class Photo < ActiveRecord::Base
  attr_accessible :source_url,
                  :saved_to_disk

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

  def save_to_disk
    agent = Mechanize.new

    # Deal with any redirects (e.g. bit.ly)
    initial_url = agent.get(self.source_url)
    destination_url = initial_url.uri.to_s

    agent.get(destination_url).save "../splashbox/app/assets/images/unsplash/#{ self.id }.jpg"
    mark_saved_to_disk
  end

  def mark_saved_to_disk
    self.saved_to_disk = true
    save
  end
end
