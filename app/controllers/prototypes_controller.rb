class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  

  def index
    @prototypes=Prototype.all
    
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(path_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype=Prototype.find(params[:id])
    @comment=Comment.new
    @comments=@prototype.comments.includes(:user)
    
    
  end  

  def edit
    @prototype=Prototype.find(params[:id])
    unless @prototype.user == current_user
      redirect_to root_path
    end
  
    
  end  

  def update
    @prototype=Prototype.find(params[:id])
    @prototype.update(path_params) 
 if @prototype.save
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end

   end

  def destroy
    @prototype=Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  
  private
  def path_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
end

