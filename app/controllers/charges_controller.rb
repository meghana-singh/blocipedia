class ChargesController < ApplicationController
  
  def new
    @amount = Amount.new(50_00)  
    
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.email}",
      amount: Amount.default_amount
    }
    
    customer_charges_array = []
    customer_ids           = []
    customer_amounts       = []
    
    #Grab the first 100 charges by setting the limit to 100 (Default is 10)
    charges = Stripe::Charge.list(:limit => 10)
    charges.each do |charge|
      customer_ids     << charge.id
      customer_amounts << charge.amount
    end
    
    #Use the has_more boolean to check if there are more charges.
    #Use starting_after argument inorder to fetch the next page in the list.
    while charges.has_more do
      charges = Stripe::Charge.list(:limit => 10, :starting_after => charges.data.last.id)
      charges.each do |charge|
        customer_ids     << charge.id
        customer_amounts << charge.amount
      end
    end
    
    puts customer_amounts
    puts customer_ids
    
  end

  def create
    
    if current_user.role == 'premium'
      current_user.downgrade()
      return redirect_to root_path
    end
    
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    puts Amount.default_amount
    puts "--------"
    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default_amount,
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

