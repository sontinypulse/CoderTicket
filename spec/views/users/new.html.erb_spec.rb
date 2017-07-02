require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :view do
  it 'render new.htm.erb' do
    assign(:user, User.new)
    render
    expect(view).to render_template(:new)
  end
  it 'has "Welcome to EasyTickets" text' do
    assign(:user, User.new)
    render
    expect(rendered).to have_content('Welcome to EasyTickets')
  end

  it 'has correct action path' do
    assign(:user, User.new)
    render
    assert_select 'form[action*=?]', '/users'
  end
end
