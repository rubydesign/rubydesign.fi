

describe "Pagination"  do
  before(:each) do
    sign_in
  end
  it "lists 30 clerks" do
    30.times{ create(:clerk) }
    visit_path clerks_path
  end
end
