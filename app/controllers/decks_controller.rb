class DecksController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: Decks::ReadModel.new.from_course(params[:course_uuid]).as_json(except: :course_uuid), status: :ok
      end
    end
  end

  def create
    respond_to do |format|
      format.json do
        command_bus.call(Content::AddDeckToCourse.new(deck_uuid: params[:deck_uuid], course_uuid: params[:course_uuid]))

        head :no_content
      end
    end
  end

  def cards
    respond_to do |format|
      format.json do
        render json: Cards::ReadModel.new.from_deck(params[:deck_uuid]).as_json(except: :deck_uuid), status: :ok
      end
    end
  end
end
