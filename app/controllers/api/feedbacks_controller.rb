module Api
  class FeedbacksController < ApplicationController
    def create
      @feedback = Feedback.new(name: params[:feedback][:name], comment: params[:feedback][:comment])

      if !@feedback.valid? || !@feedback.save
        render status: :bad_request, json: {}
      else
        render status: :ok, json: {}
      end
    end
  end
end
