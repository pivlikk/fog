class Candidate
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :full_name, type: String
  field :birthday, type: Date
  field :organization, type: String
  field :email, type: String
  field :phone, type: String
  field :twitter, type: String
  field :facebook, type: String
  field :vk, type: String
  #field :avatar, type: String
  
  belongs_to :municipality
  belongs_to :distinct
  
  def self.setAllAvatart
    Candidate.where(:vk.exists => true).each do |c|
      unless c.vk.blank?
        c.getAvatar()
      end
    end
  end
  
    
  def avatar
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    new_avatar = nil
    begin
      #agent.get(self.vk)
      agent.get("http://api.vk.com/method/users.get?user_ids=#{self.vk.split("/").last}&fields=photo_max")
      new_avatar = JSON.parse(agent.page.body)["response"][0]["photo_max"] rescue nil
      #agent.page.search("#page_avatar img").attr("src").text
    rescue Mechanize::ResponseReadError => e
      e.force_parse
    end
    new_avatar
    
  end
  
  def getAvatar
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    new_avatar = ""
    begin
      #agent.get(self.vk)
      agent.get("http://api.vk.com/method/users.get?user_ids=#{self.vk.split("/").last}&fields=photo_max")
      new_avatar = JSON.parse(agent.page.body)["response"][0]["photo_max"]
      #agent.page.search("#page_avatar img").attr("src").text
    rescue Mechanize::ResponseReadError => e
      e.force_parse
    end
    self.update_attributes(:avatar => new_avatar)
    
  end
  
 
  
end