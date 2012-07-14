require 'digest/sha1'

FactoryGirl.define do
  factory :git_commit do
    sha { Digest::SHA1.hexdigest(UUID.generate(:compact)) }
    email "kenmazaika@gmail.com"
    image "omgimage"
  end

  factory :user do
    name "kenmazaika"
    sequence(:github_id) {|n| n }
    sequence(:email) {|n| "kenmazaika#{n}@gmail.com" }
    token { UUID.generate(:compact) }
  end

  factory :repo do
    name { UUID.generate(:compact) }
    external_id { UUID.generate(:compact) }
  end
end
