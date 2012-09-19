require 'spec_helper'

describe UserController do

  describe "GET 'create_username'" do
    it "returns http success" do
      get 'create_username'
      response.should be_success
    end
  end

  describe "GET 'my_page'" do
    it "returns http success" do
      get 'my_page'
      response.should be_success
    end
  end

end
