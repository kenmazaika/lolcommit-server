require 'digest/sha1'

FactoryGirl.define do
  factory :git_commit do
    sha { Digest::SHA1.hexdigest(Time.now.to_i.to_s) }
    email "kenmazaika@gmail.com"
    image "omgimage"
    repo  "lolcommit-server"
  end

end
