#this file is included by category_spec, so the guard matchers work

require 'spec_helper'

describe "Category search" do
  before :each do
    sign_in
   end
   it "lists no categories" do
     visit_path categories_path
     expect(category_count).to be 0
   end
   it "lists correct number of unfiltered categories" do
     category_ab :name => ["one","two", "more"]
     expect(category_count).to be 3
   end
   it "filters by online" do
     category_ab :online => [true, false]
     choose("q[online_eq]")
     expect(category_count).to be 1
   end
   it "filters by name" do
     category_ab :name =>[ "i have a name", "nono"]
     fill_in("q[name_cont]" , :with => "name")
     expect(category_count).to be 1
   end
   it "filters by empty summary" do
     category_ab :summary =>[ "i have a summary", ""]
     choose("q[summary_blank]")
     expect(category_count).to be 1
   end
   it "filters by summary" do
     category_ab :summary =>[ "i have a summary", ""]
     fill_in("q[summary_cont]" , :with => "have")
     expect(category_count).to be 1
   end
   it "filters by description" do
     category_ab :description =>[ "i have a name", "nono"]
     fill_in("q[description_cont]" , :with => "name")
     expect(category_count).to be 1
   end
   it "filters by empty description" do
     category_ab :description =>[ "i have a description", ""]
     choose("q[description_blank]")
     expect(category_count).to be 1
   end
end
