class QuestionsController < ApplicationController
    before_action :authenticate_user

    def index
        user = auth_user
        page = params[:page].to_i || 1
        per_page = params[:perpage].to_i || 25
      
        if page <= 0 || per_page <= 0
          render json: {
            message: "Invalid pagination parameters. Page and perpage should be positive integers.",
          }, status: 400
          return
        end
        questions = Question.all.offset((page - 1) * per_page).limit(per_page)
        total_questions = Question.count
        total_pages = (total_questions / per_page.to_f).ceil
        if questions.any?
          render json: {
            message: "Questions retrieved successfully...",
            Current_Page: page,
            Total_pages: total_pages,
            Page_contains: per_page,
            Total_records: total_questions,
            questions: questions
          }, status: 200
        end
    end


    def show
        user = auth_user
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
        if current_user.role == "admin"
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
        user = auth_user
        if user.role == 'user'
            level = params[:level]
            code_language = params[:codeLanguage]
            random_question_ids = Question.where(level: level, codeLanguage: code_language).pluck(:id).sample(25)
            questions = Question.includes(:options).where(id: random_question_ids)
            if questions.any?
                render json: {
                message: "Questions of #{level} and #{code_language} language retrieved successfully...",
                data: questions.as_json(only: [:id, :question], include: { options: { only: [:option]} })
                }, status: 200
            else
                render json: {
                message: "No questions found for level #{level} and code language #{code_language}"
                }, status: 404
            end
        else
            render json: { error: "Invalid user" }, status: :unauthorized
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
