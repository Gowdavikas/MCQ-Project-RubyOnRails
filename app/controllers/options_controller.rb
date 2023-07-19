class OptionsController < ApplicationController

    def index
        option = Option.all
        if option.present?
            render json:
            {
                message: "All options retrived successfully...",
                option: option
            }, status: 200
        else
            render json:
            {
                message: "No option details found"
            }, status: 404
        end
    end

    def show
        option = set_option
        if option
            render json:
            {
                message: "Specified option retrived successfully...",
                option: option
            }, status: 200
        else
            render json:
            {
                message: "No options found for this id"
            }, status: 400
        end
    end

    def create
        option = Option.create(option_params)
        if option.save
            render json:
            {
            message: "New option created successfully...",
            option: option
            }, status: 201
        else
            render json:
            {
                message: "Sorry, new option couldn't save successfully..."
            }, status: 400
        end
    end

    def update
        option = set_option
        if option.update(option_params)
            render json:
            {
                message: "Specified option updated successfully !",
                option: option
            }, status: 200
        else
            render json:
            {
                message: "Sorry, specified option couldn't update successfully.."
            }, status: 400
        end
    end

    def destroy
        option = set_option
        if option.present?
            option.delete
            render json:
            {
                message: "Specified option deleted successfully !",
                option: option
            }, status: 200
        else
            render json:
            {
                message: "Failed to delete Specified option !"
            }, status: 400
        end
    end

    def set_option
        option = Option.find_by(id: params[:id])
        if option
            return option
        end
    end

    def option_params
        params.require(:option).permit(:option, :question_id)
    end
end
 