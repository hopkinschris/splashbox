class Photo < ActiveRecord::Base
  attr_accessible :source_url

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
end
