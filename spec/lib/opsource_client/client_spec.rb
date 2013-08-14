require 'spec_helper'

describe OpsourceClient::Client, :vcr do


  let(:settings) {
    YAML::load(File.open("test-network.yaml"))
  }

  let(:client) {
    opc = OpsourceClient::Client.new
    opc.api_endpoint = settings["api_endpoint"]
    opc.organization_id = settings["organization_id"]
    opc.admin_username = settings["admin_username"]
    opc.admin_password = settings["admin_password"]

    opc
  }


  it "should be configurable" do
    client.api_endpoint = "http://google.com/"
    client.api_endpoint.should == "http://google.com/"

    client.admin_username = "hi"
    client.admin_username.should == "hi"
  end

  it "should raise exceptions for invalid requests" do
    expect {client.all_natrules({})}.to raise_error
  end

  it "should list all natrules" do
    #https://api-au.dimensiondata.com/oec/0.9/c896bc57-3269-4163-b802-4da1bdc2acd1/network/9e95d66e-e2f7-11e1-9153-001b21cfdbe0/natrule

#     <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
# <ns4:NatRules xmlns:ns2="http://oec.api.opsource.net/schemas/organization"
# xmlns="http://oec.api.opsource.net/schemas/server" .. >
# <ns4:NatRule>
# <ns4:id>4514-a25a</ns4:id>
# <ns4:name>10.147.15.11</ns4:name>
# <ns4:natIp>63.88.83.145</ns4:natIp>
# <ns4:sourceIp>10.147.15.11</ns4:sourceIp>
# </ns4:NatRule>
# :
# <ns4:NatRule>
# <ns4:id>0958-419e</ns4:id>
# <ns4:name>10.147.15.12</ns4:name>
# <ns4:natIp>63.88.83.147</ns4:natIp>
# <ns4:sourceIp>10.147.15.12</ns4:sourceIp>
# </ns4:NatRule>

    puts client.all_natrules({:net_id => settings["network_id"]}).inspect
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