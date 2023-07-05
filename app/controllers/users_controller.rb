class UsersController < ApplicationController

    def index

        user = User.all
        if user.present?
            render json:
            {
                message: "All users retrived successfully...",
                user: user
            }, status: 200
        else
            render json:
            {
                message: "No users found"
            }, status: 400
        end
    end

    def show
        user = set_user
        if user
            render json:
            {
                message: "Specified user retrived successfully...",
                user: user
            }, status: 200
        else
            render json:
            {
                message: "No users found for this id"
            }, status: 400
        end
    end

    def create
        user = User.create(user_params)
        if user.save
            render json:
            {
                message: "New user created successfully...",
                user: user
            }, status: 201
        else
            render json:
            {
                message: "Sorry, new user couldn't save successfully..."
            }, status: 400
        end
    end

    def update
        user = set_user
        if user.update
            render json:
            {
                message: "Specified user updated successfully !",
                user: user
            }, status: 200
        else
            render json:
            {
                message: "Sorry, specified user couldn't update successfully.."
            }, status: 400
        end
    end

    def destroy
        user = set_user
        if user.present?
            user.delete
            render json:
            {
                message: "Specified user deleted successfully !",
                user: user
            }, status: 200
        else
            render json:
            {
                message: "Failed to delete Specified user !"
            }, status: 400
        end
    end

    def set_user
        user = User.find_by(id: params[:id])
        if user
            return user
        end
    end

    def user_params
        params.require(:user).permit(:name,:user,:admin)
    end
end
