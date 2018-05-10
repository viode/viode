# frozen_string_literal: true

class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find_by! name: params[:name]
    @questions = Question.tagged_with(@tag.name).recent.page(params[:page]).per(20)
  end
end
