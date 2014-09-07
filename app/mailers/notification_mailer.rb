class NotificationMailer < ActionMailer::Base
  def account_disconnected(user, filename, error)
    @user = user
    @filename = filename
    @error = error
    mail from: 'Splashbox <noreply@splashboxapp.com>', to: ENV['DROPBOX_ADMIN_EMAIL'], subject: "Splashbox - Account Disconnected (#{ @user.email })"
    smtp_headers(["notification_account_disconnected"])
  end

  private

  def smtp_headers(tags)
    @tags = tags
    headers['X-MC-AutoText'] = "true"
    headers['X-MC-Tags'] = @tags.join(",")
  end
end
