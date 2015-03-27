class User < ActiveRecord::Base
  include Splashbox::Dropbox

  after_create :get_dropbox_attributes

  serialize :completions, Array

  attr_accessible :name,
                  :email,
                  :dropbox_uid,
                  :access_token,
                  :access_secret,
                  :customer_id,
                  :completions,
                  :waitlist,
                  :disconnected

  scope :consumers,   -> { where(waitlist: false).where(disconnected: false) }
  scope :waiters,     -> { where(waitlist: true) }

  def consumer?
    not completions.empty?
  end

  private

  def get_dropbox_attributes
    set_name_and_email(self)
  end
end
