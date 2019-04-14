# Mails may be sent from the admin interface for below actions.

# The SalesClerk sends a confirm when the order is received (they are unpaid at that time)

# Default from (possibly bcc) and mail delivery method must be set up in production.rb (see rails docs)

class OrderMailer < ActionMailer::Base

  add_template_helper(ApplicationHelper)
  add_template_helper(OrdersHelper)

  def confirm(order)
    @order = order
    mail(to: @order.email, subject: "#{I18n.t(:order)} #{@order.number}")
  end
  def cancel(order)
    @order = order
    mail(to: @order.email, subject: "#{I18n.t(:order)} #{@order.number}")
  end
  def paid(order)
    @order = order
    mail(to: @order.email, subject: "#{I18n.t(:order)} #{@order.number}")
  end
  def shipped(order)
    @order = order
    mail(to: @order.email, subject: "#{I18n.t(:order)} #{@order.number}")
  end
  
end
