class EventsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.find(params[:group_id])
    @event = Event.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event = @group.events.new(event_params)
    if @event.save
      redirect_to group_event_path(@group, @event), notice: "送信が完了しました"
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
  end

  def edit
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
  end

  def update
    @group = Group.find(params[:group_id])
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to group_event_path(@group,@event), notice: "編集が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to request.referer
  end

  private

  def event_params
    params.require(:event).permit(:title, :content)
  end

  def ensure_correct_user
    @group = Group.find(params[:group_id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end
