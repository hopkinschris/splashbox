module Splashbox::Embedly

  def self.extract_colors quick_url
    begin
      client = build_client
      response = client.extract url: quick_url
      colors = response[0].marshal_dump[:images][0]['colors']
    rescue => e
      ap "An error occurred during color extraction: #{ e }"
    end

    return colors
  end

  private

  def self.build_client
    Embedly::API.new key: ENV['EMBEDLY_KEY']
  end
end
