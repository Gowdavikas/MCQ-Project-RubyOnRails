class QuestionsController < ApplicationController

    before_action :authenticate_user!

    def index

        question = Question.all
        if question.present?
            render json:
            {
                message: "All question retrived successfully...",
                question: question
            }, status: 200
        else
            render json:
            {
                message: "No questions found"
            }, status: 400
        end
    end

    def show
        question = set_question
        if question
            render json:
            {
                message: "Specified question retrived successfully...",
                question: question
            }, status: 200
        else
            render json:
            {
                message: "No questions found for this id"
            }, status: 400
        end
    end

    def create
        if current_user.admin == true
            question = Question.create(question_params)
            question.save
            render json:
            {
                message: "New question created successfully by Admin...",
                question: question
            }, status: 201
        else
            render json:
            {
                message: "Sorry, ensure whether the user having admin access...."
            }, status: 400
        end
    end

    def update
        question = set_question
        if question.update(question_params)
            render json:
            {
                message: "Specified question updated successfully !",
                question: question
            }, status: 200
        else
            render json:
            {
                message: "Sorry, specified question couldn't update successfully.."
            }, status: 400
        end
    end

    def destroy
        question = set_question
        if question.present?
            question.delete
            render json:
            {
                message: "Specified question deleted successfully !",
                question: question
            }, status: 200
        else
            render json:
            {
                message: "Failed to delete Specified question !"
            }, status: 400
        end
    end

    def level_question
        if current_user.user?
          level = params[:level]
          code_language = params[:codeLanguage]
      
          questions = Question.where(level: level, codeLanguage: code_language)
          if questions.present?
            render json: 
            {
              message: "Questions of #{level} and #{code_language} language retrieved successfully...",
              questions: questions.as_json(only: [:id, :question], include: { option: { only: [:id,:option_1,:option_2,:option_3,:option_4] } })
            }, status: 200
          else
            render json: 
            {
              message: "No questions found for level #{level} and code language #{code_language}"
            }, status: 400
          end
        else
          render json: 
          {
            message: "Sorry, user must have user access to retrieve questions by level and code language"
          }, status: 400
        end
    end
      

    def set_question
        question = Question.find_by(id: params[:id])
        if question
            return question
        end
    end

    def question_params
        params.require(:question).permit(:question,:level,:codeLanguage)
    end
end
