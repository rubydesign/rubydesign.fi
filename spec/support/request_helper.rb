module PageHelper
  def should_translate page
    status_code.should be 200
    page.should_not have_css(".translation_missing")
  end
end
