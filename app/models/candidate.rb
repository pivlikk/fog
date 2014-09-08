require 'open-uri'

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
    if self.vk.blank? or self.vk.length < 2
      return nil
    else
      "/avatars/#{self.vk.split("/").last}.jpg"
    end
  end
  
  def self.avatarFromArray
    #["valkman", "daniilken", "id115333221", "id636", "kgolokte", "lvov_ilya", "u_v_nikolaev", "arvidsever", "ekaterina.alimova", "angorbatsevich", "yoorashka", "olia_gushchina", "artemenko_nikolay", "id66100", "volkov24", "id167046305", "samvelpt", "alex.provorov", "roskin_m", "id885243", "minakovas", "id65948907", "id1131235", "julia.l.alimova", "shurshev", "id138860", "av_davydov", "d.anisimov", "id291259", "s.vinnichenko", "azamaraeva", "serg_troshin", "volokhonsky", "id1695", "id206891687", "kattterina86", "good3376", "golovach_alexander", "id359775", "ebaranovsky", "kasatkin62", "goodfed", "zirkunov", "zirkunov", "vasilyevden", "listopad78", "id3416896", "ekaterina_shishova", "id158369", "rinkevich", "stafeev", "id67642", "id1094583", "id1094583", "id710519", "d.f.katcuba", "id1058532", "id1058532", "nikotin108", "id95262515", "otsidaeva", "id201853791", "amg_max", "amg_max", "id39126478", "id68528", "id1744768", "tonyzorin", "plotnikovohta", "plotnikovohta", "zloyslov", "mironenkotatiana", "mironenkotatiana", "mironenkotatiana", "skirjuk", "id193309", "id34506", "id34506", "mac87", "matishinec", "id72689169", "id7239501", "id51648365", "kvshamiev", "id1170477 ", "begrippo", "evdokimkulagin", "yakimov_vladimir", "id264011420", "n.vavilina", "n.vavilina", "n.vavilina", "kasatkin62", "shvetspavel", "shvetspavel", "vishnev", "neste", "neste", "neste", "id19124485", "lapitskiy", "evgeny_valikov", "alexandrandreyev", "id25540801", "petershved", "abelyaev90", "id359775", "natalia.graz", "brewerov", "papevsky", "id1011782", "id7007018", "id2041243", "ustinovich", "id154944041"]
    arr = ["id887582", "id4701236", "kaisernik", "samvelpt", "fordzon", "azurro", "ppopoff", "a_arzhaev", "n.k.minaev", "svoboda57", "visvaldi", "sartakovru", "id931337", "den_ezln", "backa", "id254780", "id2748891", "id332199", "id17897", "id188107397", "id2812961", "id2812961", "id2812961", "ilkonovalov", "ilkonovalov", "vetohina", "vetohina", "id85587101", "id85587101", "whitey", "id5319932", "id511408", "id3510673", "id4818983", "immaruinucunt", "sophie_tchistiacova", "id30424955", "id5303885", "id159863845", "fonsebaton", "theodorkushnarenko", "alexfitness1", "bakan", "romashka1971", "id3301319", "vbuevich", "id16469176", "alena_buevich", "apashinsky", "sezam", "id1388543", "id5611908", "konstina", "konstina", "vint67", "vint67", "yermachenkov", "id591815", "petrovsky2", "petrovsky2", "jedi_987", "id32555302", "winerose", "sorokinspb", "sorokinspb", "maybefree", "id42722799", "id42722799", "id58793", "p_galitovskiy", "id6119100", "id26757752", "ebaranovsky", "chivilgin", "id38324722", "id177577720", "id177577720", "kazarich", "id43365149", "l_victory", "id1131235", "vetugov", "id37850438", "marinatishenco", "goldcoin", "id84689275", "id6624413", "n.bakatina", "id27299707", "s_v65", "id19324957", "id44283576", "id5254546", "id66228367", "5tanislav", "5tanislav", "id213219991", "id213219991", "id1228811", "giugiu", "id264403552", "alexander.kornichenko", "ira_laska", "d.sventik", "id561484", "artemyevs", "id4832007", "id11542341", "id2009530", "id656098", "id236024934", "id15696034", "id6660864"]
    
    arr.each do |user_id|
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'
      new_avatar = nil
      agent.get("http://api.vk.com/method/users.get?user_ids=#{user_id}&fields=photo_max")
    
      open(Rails.root.join("public", "avatars", "#{user_id}.jpg"), 'wb') do |file|
        file << open(JSON.parse(agent.page.body)["response"][0]["photo_max"]).read rescue nil
      end
    end
    
  end
  def getAvatar
    
    unless self.vk.blank? or self.vk.length < 2
      agent = Mechanize.new
      agent.user_agent_alias = 'Mac Safari'
      new_avatar = nil
      user_id = self.vk.split("/").last
      agent.get("http://api.vk.com/method/users.get?user_ids=#{user_id}&fields=photo_max")
      
      open(Rails.root.join("public", "avatars", "#{user_id}.jpg"), 'wb') do |file|
        file << open(JSON.parse(agent.page.body)["response"][0]["photo_max"]).read rescue nil
      end
    end
  end
  
 
  
end