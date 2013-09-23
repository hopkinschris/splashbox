module Splashbox::Dropbox

  def upload_file(user, filename, image)
    client = client || build_client(user)
    client.upload filename, image
  end

  def set_name_and_email(user)
    client = client || build_client(user)
    name  = client.account.display_name
    email = client.account.email
    user.update_attributes(name: name, email: email)
  end

  private

  def build_client(user)
    begin
      Dropbox::API::Client.new token: user.access_token, secret: user.access_secret
    rescue => e
      user.deactivate
      puts "#{ user.name }'s account has been deactivated."
      puts "#{ e.message }"
    end
  end
end
