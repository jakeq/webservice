class EventsController < ApplicationController
	before_action :set_event, :only => [ :show, :edit, :update, :destroy]

	def index
		@events = Event.page(params[:page]).per(5)

		respond_to do |format|
			format.html
			format.xml { render :xml => @events.to_xml }
			format.json { render :json => @events.to_json }
			
		end
	end
	def new_event_path
		@event = Event.new
	end
	def create
		@event = Event.new(event_params)
  		if @event.save
    		redirect_to events_url
  		else
    		render :action => :new
  		end
  		flash[:notice] = "event was successfully created"
	end
	def show
		@page_title = @event.name
	end
	def edit
	end
	def update
		if @event.update(event_params)
    		redirect_to :action => :show, :id => @event
  		else
    		render :action => :edit
  		end
  		flash[:notice] = "event was successfully updated"
	end
	def destroy
		@event.destroy

		redirect_to events_url(@event)
		flash[:alert] = "event was successfully deleted"
	end

	private

	def event_params
		params.require(:event).permit(:name, :description)
	end
	def set_event
  		@event = Event.find(params[:id])
	end
end
