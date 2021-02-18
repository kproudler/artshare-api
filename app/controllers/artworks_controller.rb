class ArtworksController < ApplicationController

    def index
        @artworks = Artwork.all.order(id: :desc)
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
            redirect_to action: :index
            flash[:notice] = 'Image Posted.'
        else
            render json: @artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show
        @artwork = Artwork.find(params[:id])
        @user = User.find_by id: @artwork[:artist_id]
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
        params.permit(:title, :artist_id, :picture, :description)
    end

end