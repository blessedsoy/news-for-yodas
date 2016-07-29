class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  def self.random_string
    value = ""
    4.times{ value  << (97 + rand(25)).chr }
    value
  end

  def self.yoda_speak(sentence)
    response = Unirest.get "https://yoda.p.mashape.com/yoda?sentence=#{URI.escape(sentence.split(/\s+/).join("+"))}",
  headers:{
    "X-Mashape-Key" => "E8TI2pOWFwmshk02Wjif3Hu91xDGp1F5TZIjsniy4SUhEzkTUy",
    "Accept" => "text/plain"
  }
    response.body  
  end
end
