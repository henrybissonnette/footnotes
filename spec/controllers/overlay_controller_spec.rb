require 'spec_helper'

describe OverlayController do

  describe 'GET #view' do
    before do
      get :view, external_url: "http://google.com"
    end

    it "responds with a 200" do
      response.status.should == 200
    end

    it 'should render the overlay view view' do
      response.should render_template("overlay/view")
    end

    it 'should make external_url available to view' do
      assigns[:external_url].should == "http://google.com"
    end
  end  

  describe '#proxy' do
    it "renders an empty string when from click is 'true'" do
      get :proxy, external_url: "http://google.com", from_click: 'true'
      response.body.should == ''
    end
  end
end