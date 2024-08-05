# app/controllers/decidim/feeds/user_answers_controller.rb
module Decidim
  module Feeds
    class UserAnswersController < ApplicationController

      def create
        answer_id = params[:answer_id].to_i
        checked = params[:checked].to_s.downcase == "true" ? true : false

        answer = Answer.find(answer_id)

        if checked
          if answer.question.single_choice?
            UserAnswer.where(decidim_user_id: current_user.id, decidim_feeds_answer_id: answer.question.answers.pluck(:id)).destroy_all
          end
          UserAnswer.find_or_create_by(decidim_user_id: current_user.id, decidim_feeds_answer_id: answer_id)
        else
          UserAnswer.where(decidim_user_id: current_user.id, decidim_feeds_answer_id: answer_id).destroy_all
        end

        # get count of user_answers for all answers of the question
        user_answers_counts = {}
        answer.question.answers.each do |a|
          user_answers_counts[a.id] = UserAnswer.where(decidim_feeds_answer_id: a.id).count
        end
        result = {
          user_answers: user_answers_counts,
          survey_responses_count: answer.question.post.survey_responses_count
        }

        render json: result, status: :ok
      end

    end
  end
end
