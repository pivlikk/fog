#encoding: utf-8
class Area
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
    
  field :name, type: String
  field :area_number, type: String
  field :voting_address, type: String
  field :including_addresses, type: String
  field :street, type: String
  field :home_numbers, type: String
  
  belongs_to :municipality
  belongs_to :distinct
  search_in :including_addresses
  
  def self.correcting_address address
    address = address.gsub(/ к.(\d+)/i, ' к\1')
    address = address.gsub(/ к.\s+(\d+)/i, ' к\1')
    address = address.gsub(/ к\s+(\d+)/i, ' к\1')
    address = address.gsub(/ кор\s+(\d+)/i, ' к\1')
    address = address.gsub(/ кор.(\d+)/i, ' к\1')
    address = address.gsub(/ кор(\d+)/i, ' к\1')
    address = address.gsub(/ корп(\d+)/i, ' к\1')
    address = address.gsub(/ корп.(\d+)/i, ' к\1')
    address = address.gsub(/ корп.\s+(\d+)/i, ' к\1')
    address = address.gsub(/ корп\s+(\d+)/i, ' к\1')
    address = address.gsub(/ корпус\s+(\d+)/i, ' к\1')
    address = address.gsub(/ корпус(\d+)/i, ' к\1')
    address = address.gsub(/ корпус.(\d+)/i, ' к\1')
    address = address.gsub(/ корпус.\s+(\d+)/i, ' к\1')
    address
  end
  
  def self.separate_address
    addr_s = self.including_addresses.split(",")
    self.update_attributes(:street => addr_s[0])
    self.update_attributes(:home_numbers => addr_s[1..10]) unless addr_s[1..10].nil?
  end
  
  def self.fix_address
    Area.all.each do |a|
      if a.including_addresses =~ /(\d)(к\d)/i
        addr = a.including_addresses.gsub(/(\d)(к\d)/i, '\1 \2')
        a.update_attributes(:including_addresses => addr)
      end
    end
  end
end