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
                  :waitlist

  scope :admin,       -> { where(dropbox_uid: ENV['DROPBOX_ADMIN_ID']).first }
  scope :consumers,   -> { where(waitlist: false) }
  scope :waiters,     -> { where(waitlist: true) }
  scope :donater,     -> { where.not(customer_id: nil) }

  def donater?
    customer_id?
  end

  def consumer?
    not completions.empty?
  end

  private

  def get_dropbox_attributes
    set_name_and_email(self)
  end
end
