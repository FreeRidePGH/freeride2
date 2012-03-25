class BikesController < ApplicationController
  
  before_filter :fetch_bike, 
  :only => [:show, :edit,:update,
            :new_comment,
            :vacate_hook, 
            :reserve_hook]
  
  def new
    @bike = Bike.new()
  end

  def show
    @hook = @bike.hook unless @bike.nil?
    @hook ||= Hook.next_available

    @project = @bike.project unless @bike.nil?
    @program = Program.find(params[:program_id]) \
    unless params[:program_id].nil?

    @project ||= @program.project_category.project_class.new()\
    unless @program.nil?
    @project ||= Project.new

    @comment = Comment.build_from(@bike, current_user, "")
  end

  def index
    @title = "Bikes Index"
    @bikes = Bike.all
  end

  def create    
    @bike = Bike.new(params[:bike])
    render :new
  end

  def edit
    @title = "Edit Bike"
  end

  def update
    if @bike.update_attributes(params[:bike])
      flash[:success] = "Bike info updated"
      redirect_to @bike
    else
      @title = "Edit Bike"
      render 'edit'
    end
  end

  def vacate_hook
    if @bike.vacate_hook!
      flash[:success] = "Hook vacated"
    else
      flash[:error] = "Could not vacate hook"
    end

      redirect_to @bike
  end

  def reserve_hook
    @hook = Hook.find(params[:hook_id])
    if @bike.reserve_hook!(@hook)
      flash[:success] = "Hook #{@bike.hook.number} reserved successfully"
    else
      flash[:error] = "Could not reserve the hook."
    end
    
    redirect_to @bike
  end


  private

  # Helper method that assigns the bike or redirects if invalid
  def fetch_bike
    @bike = Bike.find(params[:id])
    if @bike
      @title = "Bike Information for" + @bike.number.to_s
    else
      redirect_to bikes_path
    end
    @bikes = [@bike]
  end



end
