class CollaboratorsController < ApplicationController
    def new
      @collaborator = Collaborator.new
      
      @wiki = Wiki.find(params[:wiki_id])
      
      @collaborating_users = @wiki.collaborators.map { |colab| colab.user }           
      
      @users_currently_not_collaborating = User.where.not(id: @collaborating_users.map {|user| user.id})
      
    end
    
    def create
      wiki_id = params[:wiki_id]
      colab_id = params[:user_id]
      
      collaborator = Collaborator.new(wiki_id: wiki_id, user_id: colab_id)
      puts collaborator
      
      if collaborator.save
        flash[:notice] = "Colaborator #{collaborator.user.email} saved."
      else
        flash[:alert] = " Collaborator #{collaborator.user.email} save failed."
      end
      redirect_to new_wiki_collaborator_path
    end
    
    def destroy
      wiki_id  = params[:wiki_id]
      colab_id = params[:user_id]
      
      collaborator = Collaborator.find_by(wiki_id: wiki_id, user_id: colab_id)
      puts collaborator
=begin
      if collaborator.destroy
        flash[:notice] = "Colaborator #{collaborator.user.email} was removed from wiki."
      else
        flash[:alert] = " Collaborator #{collaborator.user.email} could not be removed."
      end
=end
      
      redirect_to new_wiki_collaborator_path
    end
    
end
