require 'nokogiri'
require 'open-uri'

class Scraper
  def initialize
    @range ||= 1..999
  end

  def run
    @range.each do |page|
      html = open_post page
      break if html.empty?
      html.each do |post|
        quick_url = post.search('img').first.attributes['src'].value
        source_url = post.search('.photo_div a').first.attributes['href'].value
        author_name = post.search('.caption a').last.text
        author_url = post.search('.caption a').last.attributes['href'].value unless post.search('.caption a').last.attributes['href'].nil?

        unless Photo.find_by_source_url(source_url)
          Photo.new_from_scraper source_url, quick_url, author_name, author_url
          puts "Photo created * #{ source_url }"
        end
      end
    end
  end

  # Used to backfill author data
  def get_author_data
    @range.each do |page|
      html = open_post page
      break if html.empty?
      html.each do |post|
        source_url = post.search('.photo_div a').first.attributes['href'].value
        author_name = post.search('.caption a').last.text
        author_url = post.search('.caption a').last.attributes['href'].value unless post.search('.caption a').last.attributes['href'].nil?

        if photo = Photo.find_by_source_url(source_url)
          if (photo.author_url || photo.author_name).blank?
            photo.update_attributes! author_name: author_name, author_url: author_url
            puts "Updated author details * #{ author_name }"
          end
        end
      end
    end
  end

  # Used to backfill quick_url data
  def get_quick_urls
    @range.each do |page|
      html = open_post page
      break if html.empty?
      html.each do |post|
        quick_url = post.search('img').first.attributes['src'].value
        source_url = post.search('.photo_div a').first.attributes['href'].value

        if photo = Photo.find_by_source_url(source_url)
          photo.update_attributes! quick_url: quick_url
          puts "Updated quick url for * #{ photo.id }.jpg"
        end
      end
    end
  end

  private

  def open_post page
    doc = Nokogiri::HTML(open("http://unsplash.com/page/#{ page }"))
    doc.css('.post')
  end
end
