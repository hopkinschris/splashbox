module Splashbox::Dropbox

  def upload_file(filename, image)
    admin = User.admin
    build_admin_client(admin)
    @admin_client.upload filename, image
  end

  private

  def build_admin_client(admin)
    @admin_client = Dropbox::API::Client.new token: admin.access_token, secret: admin.access_secret
  end
end
