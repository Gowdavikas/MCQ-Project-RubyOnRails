class AcademicsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        academic = Academic.all
        if academic.empty?
            render json:
            {
                message: "No academics found"
            }, status: 404
        else
            render json:
            {
                message: "All academics retrived successfully",
                academic: academic
            }, status: 200
        end
    end

    def show
        academic = set_academic
        if academic
            render json:
            {
                message: "specified academic retrived successfully...",
                academic: academic
            }, status: 200
        else
            render json:
            {
                message: "Sorry!, specified academic not found"
            }, status: 404
        end
    end

    def create
        begin
        academic = Academic.create(academic_params)
        if academic.save
            current_user.update(academic_status: true)
            render json:
            {
                message: "New academic saved successfully",
                academic: AcademicSerializer.new(academic),
                interest: InterestSerializer.new(academic.interest),
                qualification: QualificationSerializer.new(academic.qualification)
            }, status: 201
        else
            render json:
            {
                message: "Sorry!, new academic failed to create",
                error: academic.errors.full_messages
            }, status: 400
        end

        rescue JWT::DecodeError => e
            Rails.logger.error("JWT Decode Error: #{e.message}")
            render json: { error: "Token not provided  / invalid token" }, status: 400
        end
    end

    def update
        academic = set_academic
        if academic.update(academic_params)
            render json:
            {
                message: "Specified academic details updates successfully",
                academic: academic
            }, status: 200
        else
            render json:
            {
                message: "Sorry!,specified academic details failed to update "
            }, status: 400
        end
    end

    def destroy
        academic = set_academic
        if academic.present?
            academic.delete
            render json:
            {
                message: "Specified academic deleted successfully...",
                academic: academic
            }, status: 200
        else
            render json:
            {
                message: "Sorry!,specified academic details failed to delete"
            }, status: 400
        end
    end


    def set_academic
        academic = Academic.find_by(id: params[:id])
        if academic
            return academic
        end
    end 

    def academic_params
        current_user_id = current_user.id
        params.permit(:college_name,:career_goals,:language,:other_language,:currently_working,:specialization,:experience,:availability,:cv,:govt_id,:interest_id,:qualification_id).merge(user_id: current_user_id)
    end
end