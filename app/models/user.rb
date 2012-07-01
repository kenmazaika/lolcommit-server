class User < ActiveRecord::Base
   attr_accessible :github_id, :email, :name, :token
   before_create :generate_api_credentials


   private

   def generate_api_credentials
     self.api_key    = UUID.generate(:compact)
     self.api_secret = UUID.generate(:compact)
   end
end
