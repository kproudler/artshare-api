class ArtworksController < ApplicationController

    def index
        @artworks = Artwork.all
        @users = User.all
        if params[:user_id]
            render json: Artwork.artworks_for_user_id(params[:user_id])
        else
            render :index
        end

        # render json: Artwork.artworks_for_user_id(params[:user_id])
    end

    def create
        @artwork = Artwork.new(artwork_params)
        @artwork.picture.attach(params[:picture])
        if @artwork.save
            render :index
        else
            render json: @artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        @artwork = Artwork.find(params[:id])
        render :show
    end

    def destroy
        artwork = Artwork.find(params[:id])
        artwork.destroy
        render json: artwork
    end

    def update
        artwork = Artwork.find(params[:id])
        if artwork.update_attributes(artwork_params)
            render :show
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :artist_id, :picture, :description)
    end

end