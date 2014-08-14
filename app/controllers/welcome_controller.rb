class WelcomeController < ApplicationController
  def index
    @candidates = []
  end
  def search
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
