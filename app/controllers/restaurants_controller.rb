class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @user = current_user
    @restaurant = @user.restaurants.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = 'Restaurant added successfully'
      redirect_to restaurants_path
    else
      render "new"
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params) if @restaurant.belongs_to?(current_user)
    redirect_to restaurants_path
  end

  def destroy
     @restaurant = Restaurant.find(params[:id])
     if @restaurant.belongs_to?(current_user)
       @restaurant.destroy
       flash[:notice]= "Restaurant successfully deleted"
     end
     redirect_to restaurants_path
   end

private
  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

end
