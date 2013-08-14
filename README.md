## ruby-opsource
=============

(WORK IN PROGRESS ...)

Ruby client for Opsource cloud's REST API - http://www.opsource.net/Services/Cloud-Hosting/Open-API

To use it as a gem -
     gem 'opsource_client', git: 'https://github.com/udayakiran/opsource_client.git'

To use it as a rails plugin -

     git clone https://github.com/udayakiran/opsource_client.git

     copy opsource_client to vendors/plugins

## Configuration -

This is a one time configuration where you specify your opsource account's organization id,
username and password of the admin account using which API calls need to be made.

    client = OpsourceClient::Client.new
    client.organization_id = organization_id
    client.admin_username =  admin_username
    client.admin_password =  admin_password

Consider putting this into yaml:
    # See https://api-(yourcloudname).dimensiondata.com/oec/0.9/myaccount for details

    organization_id: c896dc57-3269-4163-b802-4da1bdc2acd1
    admin_username: you@company.com
    admin_password: 
    network_id:  9e95df6e-e2f7-11e1-9153-d01b21cfdbe0
    api_endpoint: api-au.dimensiondata.com

  

## Sample usage



    #!/usr/bin/env ruby
    require 'opsource_client'
    require 'yaml'

    config = ARGF.argv.first

    if config.nil?
        puts "Usage: bundle exec manage_network [config_file]"
    end

    settings = YAML::load(File.open("#{config}.yaml"))


    opc = OpsourceClient::Client.new
    opc.api_endpoint = settings["api_endpoint"]
    opc.organization_id = settings["organization_id"]
    opc.admin_username = settings["admin_username"]
    opc.admin_password = settings["admin_password"]

    puts opc.all_natrules(net_id: settings["network_id"]).inspect
    # opc.create_natrule({:net_id => settings["network_id"], :sourceIp => private_ip, :name => private_ip})



