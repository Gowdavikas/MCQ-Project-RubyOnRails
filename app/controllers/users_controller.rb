class UsersController < ApplicationController

    def index
        user = User.all
        if user.any?
            render json:
            {
                message: "All users retrived successfully...",
                user: user.as_json(only: [:id, :name, :phonenumber, :email, :jti, :role])
            }, status: 200
        end
    end

    def show
        user = set_user
        if user
            render json:
            {
                message: "Specified user retrived successfully...",
                user: user.as_json(only: [:id, :name, :phonenumber, :email, :jti, :role])
            }, status: 200
        else
            render json:
            {
                message: "No users found for this id"
            }, status: 400
        end
    end

    def update
        user = set_user
        if user.update(user_params)
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
        params.require(:user).permit(:name,:role,:phonenumber,:email,:password)
    end
end
