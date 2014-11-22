class OrderMailer < ActionMailer::Base

  def confirm(order)
    @order = order
    mail(to: @order.email, from: "me@here.now" ,  subject: "Order #{@order.number}")
  end
end
