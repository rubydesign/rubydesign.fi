class OrderMailer < ActionMailer::Base

  add_template_helper(OfficeHelper)
  add_template_helper(OrdersHelper)

  def confirm(order)
    @order = order
    mail(to: @order.email, :from => from ,  subject: "Order #{@order.number}")
  end
  def cancel(order)
    @order = order
    mail(to: @order.email, :from => from ,  subject: "Order #{@order.number}")
  end
  def paid(order)
    @order = order
    mail(to: @order.email, :from => from ,  subject: "Order #{@order.number}")
  end
  def shipped(order)
    @order = order
    mail(to: @order.email, :from => from ,  subject: "Order #{@order.number}")
  end
  
  private
  def from
    OfficeClerk.config(:mail_from)
  end
end
