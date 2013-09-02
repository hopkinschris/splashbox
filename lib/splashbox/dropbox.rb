module Splashbox::Dropbox

  def upload_file(filename, image)
    user = User.last
    build_client(user)
    @client.upload filename, image
  end

  private

  def build_client(user)
    @client = Dropbox::API::Client.new token: user.access_token, secret: user.access_secret
  end
end
