#encoding: utf-8
class WelcomeController < ApplicationController
  before_action :setup_search, :only => [:search, :share_link, :print, :fshare]
  def index
    @candidates = []
    @info = []
    @info << OpenStruct.new(:number => "10 800 000", :subnumber => "", :text => "рублей  украли на благоустройстве в МО Остров Декабристов в 2013 году.", :font_size => "5em")
    @info << OpenStruct.new(:number => "5 000 000", :subnumber => "", :text => "рублей зарабатывает глава муниципалитета за пять лет.", :font_size => "5em")
    @info << OpenStruct.new(:number => "1 500", :subnumber => "", :text => "независимых кандидатов не пустили на выборы, используя различные махинации.", :font_size => "5em")
    @info << OpenStruct.new(:number => "5", :subnumber => "лет", :text => "тюремного заключения грозит тем, кто фальсифицирует выборы.", :font_size => "5em")
    @info << OpenStruct.new(:number => "Бесконечность", :subnumber => "", :text => "Столько времени муниципалы будут воровать, если мы не научимся их контролировать и не изберем достойных. ", :font_size => "3em")
    
    @super_info = @info.shuffle.first
  end
  
  def print
    render :layout => "share"
  end
  
  
  
  def share
    
    @candidates = Candidate.where(:distinct_id.in => params[:distincts].split(", "))
    @distincts = Distinct.where(:id.in => params[:distincts].split(", "))
    @municipality = Municipality.find(params[:municipality_id]).title
    @small = @distincts.length < 4
    render :layout => "share"
  end 
  
  def share_link
    @kit = IMGKit.new("http://fog.app.mo2014.ru/share?distincts=#{@distincts.map(&:id).join(', ')}&municipality_id=#{@municipality_id}")
    image = MiniMagick::Image.read(@kit.to_jpg)
    image.trim

    file_name = (0...7).map { ('a'..'z').to_a[rand(26)] }.join+".jpg"
    #send_data(image.to_blob, :type => 'image/jpg', :disposition => 'inline')
    file = Rails.root.join('public','uploads', file_name) 
    
    File.open(file, "wb") do |f|
        f.write(image.to_blob)
    end
    
    #@file_url = "http://fog.app.mo2014.ru/uploads/#{file_name}"
    render :text => "http://mo2014.ru/uploads/#{file_name}"
  end 
  
  def search

  end

  def search_old
    @candidates = []
    @show_error = false
    @no_candidates = false
    area = Area.full_text_search(params[:search], match: :all)
    if !area.empty? and area.first.municipality and params[:search].length > 6
      @municipality = area.first.municipality.title
      @candidates = Candidate.where(:distinct_id.in => area.first.municipality.distincts.map(&:_id))
    else
      @show_error = true
    end
    if @candidates.empty?
      @no_candidates = true
    end
  end
  
  private
  def setup_search
    @candidates = []
    @show_error = false
    @no_candidates = false
    municipalities = Municipality.where(:title => params[:name])

    if !municipalities.empty?
      municipality = municipalities.first
      @municipality = municipality.title
      @municipality_id = municipality.id
      array  = ["улица", "проулок", "площадь", "проспект", "дом", "д.", " д "]
      tmp_search_street = params[:street].split(", ").last.split.delete_if{|x| array.include?(x.downcase)}.join(' ') rescue ""
      search_street = Area.correcting_address(tmp_search_street)
      @search_street = search_street
      area = municipality.areas.full_text_search(search_street, match: :all, minimum_word_size: 1).where(:distinct_id.exists => true)

      if !area.empty?
          @distincts = Distinct.where(:id.in => area.map(&:distinct_id))
      end
      
      unless @distincts
        @distincts = municipality.distincts
      end
      
      @candidates = Candidate.where(:distinct_id.in => @distincts.map(&:_id))
    else
      @show_error = true
    end
    if @candidates.empty?
      @no_candidates = true
    end
  end
end
