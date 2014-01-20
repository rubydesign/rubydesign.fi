module PageHelper
  def translates page
    page.should_not have_css(".translation_missing")  
  end
end
