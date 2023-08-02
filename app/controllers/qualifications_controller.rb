class QualificationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        qualification = Qualification.all
        if qualification.any?
            render json:
            {
                message: "All qualification retrived successfully",
                qualification: qualification
            }, status: 200
        else
            render json:
            {
                message: "No qualifications found"
            }, status: 404
        end
    end

    def show
        qualification = set_qualification
        if qualification
            render json:
            {
                message: "specified qualification retrived successfully...",
                qualification: qualification
            }, status: 200
        else
            render json:
            {
                message: "Sorry!, specified qualification not found"
            }, status: 404
        end
    end

    def create
        qualification = Qualification.create(qualification_params)
        if qualification.save
            render json:
            {
                message: "New qualification saved successfully",
                qualification: qualification
            }, status: 201
        else
            render json:
            {
                message: "Sorry!, new qualification failed to create"
            }, status: 400
        end
    end

    def update
        qualification = set_qualification
        if qualification.update(qualification_params)
            render json:
            {
                message: "Specified qualification details updates successfully",
                qualification: qualification
            }, status: 200
        else
            render json:
            {
                message: "Sorry!,specified qualification details failed to update "
            }, status: 400
        end
    end

    def destroy
        qualification = set_qualification
        if qualification.present?
            qualification.delete
            render json:
            {
                message: "Specified qualification deleted successfully...",
                qualification: qualification
            }, status: 200
        else
            render json:
            {
                message: "Sorry!,specified qualification details failed to delete"
            }, status: 400
        end
    end

    def set_qualification
        qualification = Qualification.find_by(id: params[:id])
        if qualification
            return qualification
        end
    end

    def qualification_params
        params.require(:qualification).permit(:name)
    end
end
