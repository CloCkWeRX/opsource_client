module OpsourceClient
  class Client
    
    def all_acls(params)
      req_params = {:net_id => ''}.merge(params)
      self.get("/network/#{req_params[:net_id]}/aclrule", nil)
    end

    def create_acl(params)
      req_params = {:net_id => '', :name => ''}.merge(params)
      self.post("/network/#{req_params[:net_id]}/acl", create_acl_request_xml(req_params))
    end

    def delete_acl(params)
      req_params = {:net_id => '', :natrule_id => ''}.merge(params)
      self.get("/network/#{req_params[:net_id]}/aclrule/#{req_params[:natrule_id]}?delete", nil)
    end

    # TODO Refactor / cleanup
    def create_acl_request_xml(params)
      xml = xml_header
      xml += %Q{
<AclRule xmlns="http://oec.api.opsource.net/schemas/network">
<!-- mandatory, string, cannot exceed 60 chars in length -->
<name>#{params[:name]}</name>
<!-- mandatory, integer, valid range is 100-500 inclusive -->
<position>#{params[:position]}</position>
<!-- mandatory, string, one of (PERMIT,DENY) -->
<action>#{params[:action]}</action>
<!-- mandatory, string, one of (IP,ICMP,TCP,UDP) -->
<protocol>#{params[:protocol]}</protocol>
}

    # <!-- optional, string, IPv4 dot decimal format. -->
    # <!-- either an host IP Address or the valid CIDR boundary when a
    # netmask is also specified below. -->
    if params[:sourceIp]
      xml += %Q{<sourceIpRange><ipAddress>#{params[:sourceIp]}</ipAddress></sourceIpRange>}
    elsif params[:sourceIpRange]
      xml += %Q{<sourceIpRange><netmask>#{params[:sourceIpRange]}</netmask></sourceIpRange>}
    end

    if params[:destinationIp]
      xml += %Q{<destinationIpRange><ipAddress>#{params[:destinationIp]}</ipAddress></destinationIpRange>}
    elsif params[:destinationIpRange]
      xml += %Q{<destinationIpRange><netmask>#{params[:destinationIpRange]}</netmask></destinationIpRange>}
    end

    xml += %Q{  
  <portRange>
  <!-- mandatory, string, one of
  (ALL,EQUAL_TO,RANGE,GREATER_THAN,LESS_THAN) -->
  <type>#{params[:range]}</type>
  <!-- optional, integer, 1-65535 -->
  <port1>#{params[:port_start]}</port1>
  <!-- optional, integer, 1-65535 -->
  <port2>#{params[:port_end]}</port2>
  </portRange>
  <!-- optional, one of (OUTSIDE_ACL,INSIDE_ACL). Default if not specified
  is OUTSIDE_ACL -->
  <type>#{params[:type]}/type>
</AclRule>
}
    end
  end
end
