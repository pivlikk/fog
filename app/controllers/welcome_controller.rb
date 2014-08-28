class WelcomeController < ApplicationController
  def index
    @candidates = []
  end
  def search

    @candidates = []
    @show_error = false
    @no_candidates = false
    municipalities = Municipality.where(:title => params[:name])

    if !municipalities.empty?
      municipality = municipalities.first
      @municipality = municipality.title
      
      search_street = params[:street].split(", ").last rescue ""
      area = municipality.areas.full_text_search(search_street, match: :all).where(:distinct_id.exists => true)

      if !area.empty?
          @distincts = Distinct.where(:_id => area.first.distinct_id)
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
end
