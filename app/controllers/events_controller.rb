class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    items_per_page = 10
    @pagy, @events = pagy(filtered_events, items: items_per_page)
  end

  def show
    weather_service = WeatherService.new
    @weather_data = weather_service.get_weather_by_date(@event.date, 'Минск')
    
    #binding.pry
    
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if event_creation_allowed?
      if @event.update(event_params)
        redirect_to @event, notice: 'Event was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to @event, alert: 'Event cannot be updated after 5 hours of creation.'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :date, :description, :category_id)
  end
  
  def filtered_events
    events = Event.all
    events = events.where('name ILIKE ?', "%#{params[:name]}%") if params[:name].present?
    events = events.where(category_id: params[:category_id]) if params[:category_id].present?
    events
  end
  
 
end
