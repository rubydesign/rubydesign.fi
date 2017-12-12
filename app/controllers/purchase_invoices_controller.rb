class PurchaseInvoicesController < PurchasesController

  def show
    load_purchase
    @invoice = true
    @template = "purchase invoice"
  end

end