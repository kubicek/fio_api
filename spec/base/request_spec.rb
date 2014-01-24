require_relative "../spec_helper"

describe FioAPI::Request do

  it "should have defined token" do
    FioAPI::Request.should respond_to :token
  end

  describe "fetch" do
    before(:each) do
      @response = {response: "response"}
      HTTParty.stub(:get) { @response }
    end
  end

end
