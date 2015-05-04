require 'rails_helper'

RSpec.describe "books/index", type: :view do
  before(:each) do
    assign(:books, [
      Book.create!(
        :author => nil,
        :title => "Title",
        :user => nil,
        :user => nil
      ),
      Book.create!(
        :author => nil,
        :title => "Title",
        :user => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of books" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
