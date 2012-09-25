class OverlayController < ApplicationController
  def view
    @external_url = params[@external_url]
    @external_url ||= 'http://en.wikipedia.org/wiki/Apple'
  end
end