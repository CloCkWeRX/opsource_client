require 'spec_helper'

describe OpsourceClient::Client do

  let(:client) {
    OpsourceClient::Client.new
  }

  it "should be configurable" do
     client.api_endpoint.should == "https://api.opsourcecloud.net/oec/0.9/"

     client.api_endpoint = "http://google.com/"
     client.api_endpoint.should == "http://google.com/"

     client.admin_username = "hi"
     client.admin_username.should == "hi"
  end


  it "should list all natrules" do
    put client.all_natrules({}).inspect
  end

   # def all_natrules(params)
   #      req_params = {:net_id => ''}.merge(params)
   #      self.get("/network/#{req_params[:net_id]}/natrule", nil)
   #    end

   pending "should create a natrule"
      # def create_natrule(params)
      #   req_params = {:net_id => '', :sourceIp => '', :name => ''}.merge(params)
      #   self.post("/network/#{req_params[:net_id]}/natrule", create_natrule_request_xml(req_params))
      # end

   pending "should delete a natrule"
      # def delete(params)
      #   req_params = {:net_id => '', :natrule_id => ''}.merge(params)
      #   self.get("/network/#{req_params[:net_id]}/natrule/#{req_params[:natrule_id]}?delete", nil)
      # end

    pending "should create a packet"
    pending "should escape dodgy data"

      # def create_natrule_request_xml(params)
      #   xml = xml_header
      #   xml += '<NatRule xmlns="http://oec.api.opsource.net/schemas/network">'
      #   xml += "<name>#{params[:name]}</name> <sourceIp>#{params[:sourceIp]}</sourceIp>"
      #   xml += "</NatRule>"
      #   xml
      # end
end