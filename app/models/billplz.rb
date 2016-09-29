class Billplz
  def self.create_bill_for(order)
    HTTParty.post( "https://www.billplz.com/api/v3/bills".to_str,
      headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
      body: {
        collection_id: "x5wk1znn",
        email: order.user.email,
        name: order.user.username,
        amount: order.price*100,
        deliver: "false",
        callback_url: "http://localhost:3000/webhooks/payment_callback",
        description: "PasarMalam",
        redirect_url: "http://localhost:3000/orders/#{order.id}",
        reference_1_label: "Order Booking Ref",
        referece_1_: order.id
      }.to_json,
      basic_auth: { username: "7294c513-078b-4bdd-b247-dda7dedb9094" }
      )
  end

  def self.check_status(order_id)
    order= order.find(order_id)
    url = "https://www.billplz.com/v3/bills/" + order.bill_id
    arguments = { headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                basic_auth: { username: "7294c513-078b-4bdd-b247-dda7dedb9094" }
                }
    HTTParty.get(url,arguments)
  end
end
