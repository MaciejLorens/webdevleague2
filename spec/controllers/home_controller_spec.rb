require 'spec_helper'

describe HomeController do
  it 'home index successfully rendered' do
    get :index

    response.should be_success
    response.should render_template :index
  end
end
