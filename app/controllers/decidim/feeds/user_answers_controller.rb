# app/controllers/decidim/feeds/user_answers_controller.rb
module Decidim
  module Feeds
    class UserAnswersController < ApplicationController

      def create
        answer_id = params[:answer_id].to_i
        checked = params[:checked].to_s.downcase == "true" ? true : false

        if checked
          UserAnswer.find_or_create_by(decidim_user_id: current_user.id, decidim_feeds_answer_id: answer_id)
        else
          UserAnswer.where(decidim_user_id: current_user.id, decidim_feeds_answer_id: answer_id).destroy_all
        end

        head :ok
      end

    end
  end
end