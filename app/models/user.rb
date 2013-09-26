class User < ActiveRecord::Base
  include Splashbox::Dropbox

  after_create :get_dropbox_attributes

  serialize :completions, Array

  attr_accessible :name,
                  :email,
                  :dropbox_uid,
                  :access_token,
                  :access_secret,
                  :waitlist,
                  :deactivated,
                  :completions

  scope :admin,       -> { where(dropbox_uid: ENV['DROPBOX_ADMIN_ID']).first }
  scope :consumers,   -> { where(waitlist: false) }
  scope :waiting,     -> { where(waitlist: true) }
  scope :deactivated, -> { where(deactivated: true) }

  def activate
    self.waitlist = false
    save
  end

  def deactivate
    update_attributes(deactivated: true)
  end

  private

  def get_dropbox_attributes
    set_name_and_email(self)
  end
end
