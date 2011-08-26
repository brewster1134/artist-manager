module Paypal
  include ActiveMerchant::Billing

  def checkout
    work = Work.find(params[:work_id])
    case work
    when work
      setup_response = gateway.setup_purchase(work.total_price.cents,
        :ip                 => request.remote_ip,
        :items              => [{:name => work.name, :number => work.id, :quantity => 1, :description => work.description.first(100), :amount => work.price.cents}],
        :subtotal           => work.price.cents,
        :shipping           => work.shipping.cents,
        :handling           => 0,
        :tax                => 0,
        :return_url         => payments_confirm_url(:work_id => work.id),
        :cancel_return_url  => work_url(work, :payment_cancelled => true)
      )
      redirect_to gateway.redirect_url_for(setup_response.token)
    when !work.can_buy_on_site?
      redirect_to work, :alert => "This work is not for sale."
    else
      redirect_to work_index_path, :alert => "We could not find that work."
    end
  end

  def confirm
    redirect_to work_index_path, :alert => "Hmm. Something went wrong with paypal." unless params[:token]
    details_response = gateway.details_for(params[:token])
    redirect_to work_index_path, :alert => details_response.message if !details_response.success?
    @response = details_response
    render "payments/paypal/confirm"
  end

  def complete
    work = Work.find(params[:work_id])
    purchase = gateway.purchase(work.total_price,
      :ip       => request.remote_ip,
      :payer_id => params[:payer_id],
      :token    => params[:token]
    )
    
    if purchase.success?
      work.quantity -= 1
      work.save!
      redirect_to work, :notice =>  "Payment Complete!"
    else
      redirect_to work, :alert => purchase.message 
    end
  end

  def gateway
    @gateway ||= PaypalExpressGateway.new(
      :login => Settings.paypal_api_username,
      :password => Settings.paypal_api_password,
      :signature => Settings.paypal_api_signature
    )
  end
  private :gateway

end