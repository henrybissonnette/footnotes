require 'spec_helper'

describe HtmlLinkLocalizer do
  before do
    @local_string = "http://www.mydomain.com/view?var="   
  end

  it 'appends local string to well formed urls' do
    @external_url = 'www.domain.com'
    @html = '<a href="http://www.google.com">google</a>'
    @localizer = HtmlLinkLocalizer.new(@html,@local_string,@external_url)
    @localizer.should_receive(:open).and_return(@html) 
    expected = %Q{#{@local_string}http://www.google.com}
    @localizer.get_localized_html.should include(expected)
  end

  it 'appends http:// to urls that lack it' do
    @external_url = 'www.domain.com'
    @html = %Q{<a href="http://www.google.com">google</a> <div>some text</div> 
     <a href="www.bliterati.com">google</a> 
     <a href="//www.economist.com/business">google</a>}
    @localizer = HtmlLinkLocalizer.new(@html,@local_string,@external_url)
    @localizer.should_receive(:open).and_return(@html) 
    expected = [
      %Q{#{@local_string}http://www.google.com},
      %Q{#{@local_string}http://www.bliterati.com},
      %Q{#{@local_string}http://www.economist.com/business}
    ]
    @localizer.get_localized_html.should include(*expected)
  end

  it 'turns relative urls into absolute urls' do
    @external_url = 'www.domain.com/first'
    @html = %Q{<a href="/here/there">google</a> <div>some text</div> 
     <a href="thisgetstackedon/next/further">google</a> 
     <a href="#groupon">more about groupon</a>}
    @localizer = HtmlLinkLocalizer.new(@html,@local_string,@external_url)
    @localizer.should_receive(:open).and_return(@html) 
    expected = [
      %Q{#{@local_string}http://www.domain.com/here/there},
      # TODO it seems like uri parse should handle the following case
      #{}%Q{#{@local_string}http://www.domain.com/first/thisgetstackedon/next/further},
      %Q{#{@local_string}http://www.domain.com/first#groupon}
    ]
    @localizer.get_localized_html.should include(*expected)
  end
end