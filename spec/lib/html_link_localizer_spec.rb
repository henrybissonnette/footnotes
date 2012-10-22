require 'spec_helper'

describe HtmlLinkLocalizer do
  describe "get_localized_html" do
    before do
      @local_string = "http://www.mydomain.com/view?var="   
    end

    it 'appends local string to well formed urls' do
      external_url = 'www.domain.com'
      html = '<a href="http://www.google.com">google</a>'
      localizer = HtmlLinkLocalizer.new(@local_string,external_url)
      localizer.stub!(:open).and_return(html) 
      expected = %Q{#{@local_string}http://www.google.com}
      localizer.get_localized_html.should include(expected)
    end

    it 'appends http:// to urls that lack it' do
      external_url = 'www.domain.com'
      html = %Q{<a href="http://www.google.com">google</a> <div>some text</div> 
       <a href="www.bliterati.com">google</a> 
       <a href="//www.economist.com/business">google</a>}
      localizer = HtmlLinkLocalizer.new(@local_string,external_url)
      localizer.stub!(:open).and_return(html) 
      expected = [
        %Q{#{@local_string}http://www.google.com},
        %Q{#{@local_string}http://www.bliterati.com},
        %Q{#{@local_string}http://www.economist.com/business}
      ]
      localizer.get_localized_html.should include(*expected)
    end

    it 'turns relative urls into absolute urls and leave anchors alone' do
      external_url = 'www.domain.com/first'
      html = %Q{<a href="/here/there">google</a> <div>some text</div> 
       <a href="thisgetstackedon/next/further">google</a> 
       <a href="#groupon">more about groupon</a>}
      localizer = HtmlLinkLocalizer.new(@local_string,external_url)
      localizer.stub!(:open).and_return(html) 
      expected = [
        %Q{#{@local_string}http://www.domain.com/here/there},
        # TODO it seems like uri parse should handle the following case
        #{}%Q{#{@local_string}http://www.domain.com/first/thisgetstackedon/next/further},
        %Q{#groupon}
      ]
      localizer.get_localized_html.should include(*expected)
    end

    it 'works on a real page' do
      external_url = 'http://en.wikipedia.org/wiki/Apple'
      localizer = HtmlLinkLocalizer.new(@local_string,external_url)
    end
  end
  describe 'fetch_source' do  

    it 'opens the external_url' do
      controller.should_receive(:open).with("http://google.com")
      get :proxy, external_url: "http://google.com"    
    end

    it 'should localize hrefs' do
      input_urls = [
        'www.other.site.com',
        'naked.url.4.info/this/that/',
        'http://www.website.org/a/b/c/d',
        'https://www.can-have-hyphens-and-numb3rs.io/indian/ocean'
      ]

      received_html= input_urls.inject('') do |html,href|
        html << "<a href=\"#{href}\">text</a>"
      end

      expected_urls = [
        'www.other.site.com',
        'naked.url.4.info/this/that/',
        'http://www.website.org/a/b/c/d',
        'https://www.can-have-hyphens-and-numb3rs.io/indian/ocean'
      ]


      controller.stub!(:open).and_return(received_html)
      get :proxy, external_url: "http://google.com" 
      expected_urls.each do |url|
        response.body.should match(url)
      end 
    end
  end
end