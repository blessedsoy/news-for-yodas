class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.random_string
    value = ""
    4.times{ value  << (97 + rand(25)).chr }
    value
  end
end
