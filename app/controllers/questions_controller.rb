class QuestionsController < ApplicationController
    
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
            }, status: 404
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
        jwt_payload = JWT.decode(request.headers['token'], Rails.application.credentials.fetch(:secret_key_base)).first
        current_user = User.find(jwt_payload['sub'])
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
                # error: question.errors.full_messages
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
        begin
        jwt_token = request.headers['token'] || params[:token]
        if jwt_token.nil?
            render json: { error: "Token not provided" }, status: :bad_request
            return
        end
        jwt_payload = JWT.decode(request.headers['token'], Rails.application.credentials.fetch(:secret_key_base)).first
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
        rescue JWT::DecodeError => e
            Rails.logger.error("JWT Decode Error: #{e.message}")
            render json: { error: "Invalid token" }, status: :unauthorized
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
