module Splashbox::Dropbox

  def upload_file(user, filename, image)
    client = client || build_client(user)
    begin
      client.upload filename, image
    rescue => e
      puts "#{ e.message }"
    end
  end

  def set_name_and_email(user)
    client = client || build_client(user)
    name  = client.account.display_name
    email = client.account.email
    user.update_attributes(name: name, email: email)
  end

  private

  def build_client(user)
    Dropbox::API::Client.new token: user.access_token, secret: user.access_secret
  end
end
