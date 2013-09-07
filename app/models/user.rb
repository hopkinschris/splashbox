class User < ActiveRecord::Base
  attr_accessible :name,
                  :access_token,
                  :access_secret

  scope :admin,     -> { where(name: ENV['DROPBOX_ADMIN_ID']).first }
  scope :consumers, -> { where.not(name: ENV['DROPBOX_ADMIN_ID']).all }
end
