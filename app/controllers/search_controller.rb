# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    if params[:query] && params[:query].size > 1
      tags = ActsAsTaggableOn::Tag.arel_table
      @tags = ActsAsTaggableOn::Tag.where tags[:name].matches("%#{params[:query]}%")
      @questions = Question.search(params[:query]).recent.page(params[:page]).per(10)
    else
      params.delete(:query)
      @tags = []
      @questions = []
    end
  end
end
