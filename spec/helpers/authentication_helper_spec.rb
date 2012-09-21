require 'spec_helper'

describe AuthenticationHelper do

  describe 'signed_in?' do
    it 'should return true if session user_id matches a user in the db' do
      new_user = User.new
      new_user.stub!(:id).and_return(1)
      helper.session[:user_id] = new_user.id
      User.should_receive(:exists?).with(new_user.id).and_return(true)
      User.should_receive(:find).with(new_user.id).and_return(new_user)
      helper.signed_in?.should == true
    end

    it 'should return false if session user_id is nil' do
      helper.session[:user_id] = nil
      helper.signed_in?.should == false
    end
  end

  describe 'current_user' do
    it 'should return the user with the id in session user_id' do
      new_user = User.new
      new_user.stub!(:id).and_return(1)
      helper.session[:user_id] = new_user.id
      User.should_receive(:exists?).with(new_user.id).and_return(true)
      User.should_receive(:find).with(new_user.id).and_return(new_user)
      helper.current_user.should == new_user
    end

    it 'should return nil if there is no session user_id' do
      helper.session[:user_id] = nil
      helper.current_user.should == nil
    end

    it 'should return nil if a user with session user_id does not exist' do
      helper.session[:user_id] = 50
      helper.current_user.should == nil
    end

    it 'should set session user_id to nil if no user exists with that id' do
      helper.session[:user_id] = 50
      helper.current_user
      helper.session[:user_id].should == nil
    end
  end 
end