################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2016.
#
# LIMITED AND RESTRICTED RIGHTS NOTICE:
# If data or software is delivered pursuant a General Services
# Administration (GSA) contract, use, reproduction, or disclosure
# is subject to restrictions set forth in Contract No. GS-35F-05925.
#-------------------------------------------------------------
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'xclarity_client'

Puppet::Type.type(:lxca_unmanage_request).provide(:lxca_unmanage_request) do
  desc 'Unmanage request provider for LXCA resource'
  
  def create_client
    conf=XClarityClient::Configuration.new(
      :username => @resource['login_user'],
      :password => @resource['login_password'],
      :host => @resource['host'],
      :port => @resource['port'],
      :auth_type => @resource['auth_type'],
      :verify_ssl => @resource['verify_ssl']
    )
    @client = XClarityClient::Client.new(conf)
  end

  def exists?
    return if @client.nil?
  end

  def create
    create_client
  end

  def destroy
    @client = nil
  end

  def fetch_unmanage_request
    create_client if @client.nil?
    if @resource[:job_id].nil?
      raise Puppet::Error, _("Attribute job_id is mandatory for the ensurable fetch_unmanage_request")
    end

    @client.fetch_unmanage_request("#{@resource[:job_id]}").map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def unmanage_discovered_devices
    create_client if @client.nil?
    if @resource[:endpoints].nil?
      raise Puppet::Error, _("Attribute endpoints is mandatory for the ensurable unmanage_discovered_devices")
    end
    if @resource[:force].nil?
      raise Puppet::Error, _("Attribute force is mandatory for the ensurable unmanage_discovered_devices")
    end

    @client.unmanage_discovered_devices(@resource[:endpoints], "#{@resource[:force]}")
  end

end

