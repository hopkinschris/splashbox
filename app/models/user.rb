class User < ActiveRecord::Base
  attr_accessible :name,
                  :access_token,
                  :access_secret
end
