# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment = event.comments.build(event_params)
    comment.user_id = current_user.id
    if comment.save
      flash[:success] = 'Comment added'
      redirect_to event
    else
      flash[:error] = 'an error occurred'
      redirect_to event
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @event = @comment.event
    if current_user.id == @event.owner_id || current_user.admin || current_user.id == @comment.user_id
      @comment.destroy
    end
    redirect_to event_path(@event.id)
  end

  private

  def event_params
    params.require(:comment).permit(:text)
  end
end
