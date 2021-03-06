class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user = current_user
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user != current_user
      redirect_to '/'
      flash[:notice] = 'You can only edit restaurants you have added'
    end

  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def destroy
    puts current_user.inspect
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user == current_user
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:alert] = 'You can only delete restaurants you have added'
    end
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name)
  end

end
