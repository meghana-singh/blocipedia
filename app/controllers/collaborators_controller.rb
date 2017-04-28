class CollaboratorsController < ApplicationController
    def new
      @collaborator = Collaborator.new
      @users = User.all
      @wiki = Wiki.find(params[:wiki_id])
    end
    
    def create
      wiki = Wiki.find(params[:wiki_id])
      user_email = params[:user][:email]
      user = User.find_by(email: user_email)
      collaborator = wiki.collaborators.build(user: user)
     
      if collaborator.save
        flash[:notice] = "Colaborator saved."
      else
        flash[:alert] = " Collaborator save failed."
      end
    end
end
