require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :view do
  it 'has first_name field' do
    render
    expect(rendered).to have_content('first_name')
  end
end
