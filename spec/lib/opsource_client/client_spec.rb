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

  pending "should raise exceptions for invalid requests" do
    expect {client.all_natrules({})}.to raise_error
  end

  context 'with valid credentials' do
    use_vcr_cassette

    it "should list all natrules" do
      response = client.all_natrules({:net_id => settings["network_id"]})

      response.should == {
        :NatRule=>[
          {:id=>"ad2d06af-de06-4abf-b114-b49d7a6e43a7", :name=>"10.208.226.12", :natIp=>"175.184.203.234", :sourceIp=>"10.208.226.12"}, 
          {:id=>"0fdb1299-23bb-4103-997d-dbd988aac2ad", :name=>"10.208.226.17", :natIp=>"175.184.33.196", :sourceIp=>"10.208.226.17"}, 
          {:id=>"696d771a-99e9-4d2e-b904-b16a2cb1c75c", :name=>"10.208.226.18", :natIp=>"175.184.203.235", :sourceIp=>"10.208.226.18"}, 
          {:id=>"4148f78b-5e21-4620-8f81-8aff0d06c2b9", :name=>"10.208.226.20", :natIp=>"175.184.33.198", :sourceIp=>"10.208.226.20"}, 
          {:id=>"4038fbf1-e8d7-4a06-b462-693824854fc9", :name=>"10.208.226.21", :natIp=>"175.184.33.197", :sourceIp=>"10.208.226.21"}, 
          {:id=>"91d47737-068d-4d7c-8002-cbde3eab4df6", :name=>"10.208.226.26", :natIp=>"175.184.33.199", :sourceIp=>"10.208.226.26"}
        ]
      }
    end
  end

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