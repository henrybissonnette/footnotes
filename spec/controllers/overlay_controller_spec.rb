require 'spec_helper'

describe OverlayController do
  # describe 'localize_link' do
  #   before do
  #     #@controller = OverlayController.new
  #     pre_string = '/overlay/proxy?from_click=true&external_url='
  #   end

  #   it 'should prepend the local string to complete urls' do
  #     complete_urls = [
  #       'www.other.site.com',
  #       'naked.url.4.info/this/that/',
  #       'http://www.website.org/a/b/c/d',
  #       'https://www.can-have-hyphens-and-numb3rs.io/indian/ocean'
  #     ]

  #     complete_urls.each do |url|
  #       @controller.localize_link(url,url).should == url + pre_string
  #     end
  #   end

  describe 'GET #view' do
    before do
      get :view, external_url: "http://google.com"
    end

    it "responds with a 200" do
      #pp response.inspect
      response.status.should == 200
    end

    it 'should render the overlay view view' do
      response.should render_template("overlay/view")
    end

    it 'should make external_url available to view' do
      assigns[:external_url].should == "http://google.com"
    end

  end  

  # describe 'GET #proxy' do  

  #   it 'opens the external_url' do
  #     controller.should_receive(:open).with("http://google.com")
  #     get :proxy, external_url: "http://google.com"    
  #   end

  #   it 'should localize hrefs' do
  #     input_urls = [
  #       'www.other.site.com',
  #       'naked.url.4.info/this/that/',
  #       'http://www.website.org/a/b/c/d',
  #       'https://www.can-have-hyphens-and-numb3rs.io/indian/ocean'
  #     ]

  #     received_html= input_urls.inject('') do |html,href|
  #       html << "<a href=\"#{href}\">text</a>"
  #     end

  #     expected_urls = [
  #       'www.other.site.com',
  #       'naked.url.4.info/this/that/',
  #       'http://www.website.org/a/b/c/d',
  #       'https://www.can-have-hyphens-and-numb3rs.io/indian/ocean'
  #     ]


  #     controller.stub!(:open).and_return(received_html)
  #     get :proxy, external_url: "http://google.com" 
  #     expected_urls.each do |url|
  #       response.body.should match(url)
  #     end 
  #   end
  # end
end