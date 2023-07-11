class InterestsController < ApplicationController
    def index
        interest = Interest.all
        if interest.empty?
            render json:
            {
                message: "No interest found"
            }, status: 404
        else
            render json:
            {
                message: "All interests retrived successfully !",
                interest: interest
            }, status: 200
        end
    end

    def show
        interest = set_interest
        if interest
            render json:
            {
                message: "Specified id's interest retrived sucessfully",
                interest: interest
            }, status: 200
        else
            render json:
            {
                message: "Sorry!, specified id's interest not found"
            }, status: 404
        end
    end

    def create
        if interest = Interest.create(interest_params)
            render json:
            {
                message: "Successfully created new interest",
                interest: interest
            }, status: 201
        else
            render json:
            {
                message: "Failed to create new interest record"
            }, status: 400
        end
    end

    def update
        interest = set_interest
        if interest.update(interest_params)
            render json:
            {
                message: "Specified interest updated successfully",
                interest: interest
            }, status: 200
        else
            render json:
            {
                message: "Sorry, specified interest failed to update..."
            }, status: 400
        end
    end

    def destroy
        interest = set_interest
        if interest.present?
            interest.delete
            render json:
            {
                message: "Specified interest deleted successfully",
                interest: interest
            }, status: 200
        else
            render json:
            {
                message: "Sorry, failed to delete the specified interest"
            }, status: 400
        end
    end

    def set_interest
        interest = Interest.find_by(id: params[:id])
        if interest
            return interest
        end
    end

    def interest_params
        params.require(:interest).permit(:name)
    end
end
