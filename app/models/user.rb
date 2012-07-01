class User < ActiveRecord::Base
   attr_accessible :github_id, :email, :name, :token
end
