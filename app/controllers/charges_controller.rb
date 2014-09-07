class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
      card: params[:stripeToken],
      plan: 'basic',
      email: params[:email]
    )

    current_user.update_attributes! customer_id: customer.id, email: customer.email, waitlist: false
    redirect_to dashboard_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to dashboard_path
  end
end
