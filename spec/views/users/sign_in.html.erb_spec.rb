require 'rails_helper'

RSpec.describe 'users/sign_in.html.erb', type: :view do
  it 'render sign_in.htm.erb' do
    render
    expect(view).to render_template(:sign_in)
  end
  it 'has "Please Sign In" text' do
    render
    expect(rendered).to have_content('Please Sign In')
  end

  it 'has correct action path' do
    render
    assert_select 'form[action*=?]', '/users/authenticate'
  end
end
