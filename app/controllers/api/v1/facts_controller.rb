module Api
  module V1
    class FactsController < ActionController::API
      # GET /api/v1/facts
      def index
        facts = Fact.all
        render json: facts, status: :ok
      end

      # GET /api/v1/facts/:id
      def show
        fact = Fact.find(params[:id])
        render json: fact, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Fact not found" }, status: :not_found
      end

      # POST /api/v1/facts
      # For now this accepts user_id in the request body. We'll protect with tokens later.
      def create
        user = User.find(params[:user_id])
        fact = user.facts.new(fact_params)

        if fact.save
          render json: fact, status: :created
        else
          render json: { errors: fact.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found" }, status: :not_found
      end

      # PUT /api/v1/facts/:id
      def update
        fact = Fact.find(params[:id])
        if fact.update(fact_params)
          render json: fact, status: :ok
        else
          render json: { errors: fact.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Fact not found" }, status: :not_found
      end

      # DELETE /api/v1/facts/:id
      def destroy
        fact = Fact.find(params[:id])
        fact.destroy
        render json: { message: "Fact deleted" }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Fact not found" }, status: :not_found
      end

      private

      def fact_params
        params.require(:fact).permit(:fact)
      end
    end
  end
end

