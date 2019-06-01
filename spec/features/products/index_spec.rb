describe "Products filters" do
  before :each do
    sign_in
   end
   it "lists no products" do
     visit_path products_path
     expect(product_count).to be 0
   end
   it "lists correct number of unfiltered products" do
     product_ab :price => [8 ,12,14,16]
     expect(product_count).to be 4
   end
   it "filters by name" do
     product_ab :name =>[ "i have a name", "nono"]
     fill_in("q[name_cont]" , :with => "name")
     expect(product_count).to be 1
   end
   it "filters by empty summary" do
     product_ab :summary =>[ "i have a summary", ""]
     choose("q[summary_blank]")
     expect(product_count).to be 1
   end
   it "filters by summary" do
     product_ab :summary =>[ "i have a summary", ""]
     fill_in("q[summary_cont]" , :with => "have")
     expect(product_count).to be 1
   end
   it "filters by empty description" do
     product_ab :description =>[ "i have a description", ""]
     choose("q[description_blank]")
     expect(product_count).to be 1
   end
   it "filters by description" do
     product_ab :description =>[ "i have a name", "nono"]
     fill_in("q[description_cont]" , :with => "name")
     expect(product_count).to be 1
   end
   it "filters by price less" do
     product_ab :price => [8 ,12]
     fill_in "q[price_lteq]", :with => '10'
     expect(product_count).to be 1
   end
   it "filters by price greater" do
     product_ab :price => [8 ,12]
     fill_in "q[price_gteq]", :with => '10'
     expect(product_count).to be 1
   end
   it "filters by stock less" do
     product_ab :inventory => [8 ,12]
     fill_in "q[inventory_lteq]", :with => '10'
     expect(product_count).to be 1
   end
   it "filters by inventory greater" do
     product_ab :inventory => [8 ,12]
     fill_in "q[inventory_gteq]", :with => '10'
     expect(product_count).to be 1
   end
end
