class WikisController < ApplicationController
    
  after_action :verify_authorized, only: [:destroy]
  
  def index
    if (current_user.admin? || current_user.premium?)
        @wikis = Wiki.all
    else 
        @wikis = Wiki.publicly_visible
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end
  
  def create
     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body  = params[:wiki][:body]

     @wiki.user = current_user
    
     if @wiki.save
 
       flash[:notice] = "Wiki was saved."
       redirect_to [@wiki]
     else
 
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :new
     end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
    
    @wiki = Wiki.find(params[:id])
    
    @wiki.assign_attributes(wiki_params)
   
     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to [@wiki]
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
  end  
  
 def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki    
     # #8
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
 end
   
   
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
