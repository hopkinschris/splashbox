module Splashbox::Dropbox

  def upload_file user, filename, image
    begin
      client = client || build_client(user)
      client.upload filename, image
    rescue Dropbox::API::Error, Dropbox::API::Error::Unauthorized => e
      puts "Disconnected user ID: #{ user.id } account due to `#{ e.message }`..."
      disconnect_account user, filename, e.to_s
    end
  end

  def set_name_and_email user
    client = client || build_client(user)
    name  = client.account.display_name
    email = client.account.email
    user.update_attributes(name: name, email: email)
  end

  private

  def build_client user
    Dropbox::API::Client.new token: user.access_token, secret: user.access_secret
  end

  def send_notification_mail user, filename, error_msg
    NotificationMailer.account_disconnected(user, filename, error_msg).deliver
  end

  def disconnect_account user, filename, error
    unless user.disconnected
      user.update_attributes! disconnected: true
      send_notification_mail user, filename, error
    end
  end
end
