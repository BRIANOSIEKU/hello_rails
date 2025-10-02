module Api
  module V1
    class UsersController < ActionController::API
      def index
        users = User.all
        render json: users, status: :ok
      end

      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        user = User.find(params[:id])
        user.destroy
        render json: { message: "User deleted" }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      private

      def user_params
        params.require(:user).permit(:username)
      end
    end
  end
end
