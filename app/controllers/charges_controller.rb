class ChargesController < ApplicationController
  def new
    @amount = Amount.new(10_00)
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.email}",
     amount: @amount.default
    }
  end

  def create
    
    if current_user.role == 'premium'
      current_user.role = 'standard'
      current_user.save
      return redirect_to root_path
    end
    
    @amount = Amount.new(10_00)
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
 
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount.default,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
 
    flash[:notice] = "Thanks for all the money, #{current_user.email}!"
    current_user.role = 'premium'
    current_user.save
    
    redirect_to root_path # or wherever
 
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

end

