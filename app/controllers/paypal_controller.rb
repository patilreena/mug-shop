class PaypalController < ApplicationController

  def checkout

    payment = PayPal::SDK::REST::Payment.new({
      intent: 'sale',
      payer: {
        payment_method: 'paypal',
      },
      redirect_urls: {
        return_url: 'http://localhost:3000/execute', # if buy
        cancel_url: 'http://localhost:3000/',  # if cancel
      },
      transactions: [
        {
          amount: {
            total: 200,
            currency: 'AUD',
          },
          item_list: {
            items: [
              {
                price: 100,
                currency: 'AUD',
                quantity: 1,
                name: 'sample A',
              },
              {
                price: 50,
                currency: 'AUD',
                quantity: 2,
                name: 'sample B',
              },
            ],
          },
        },
      ]})

    # HTTP post request to the PayPal API
    if payment.create
      redirect_to payment.links.find{|v| v.rel == 'approval_url'}.href
    else
      render text: payment.error # return error
    end
  end

  def execute
    # pay from buyer to seller into PayPal account
    payment = PayPal::SDK::REST::Payment.find(params[:paymentId])


    if payment.execute(payer_id: params[:PayerID])
      redirect_to root_path
      flash[:notice] = 'Thank you for your purchase! payment complete!'
    else
      render text: payment.error # return error
    end
  end


end
