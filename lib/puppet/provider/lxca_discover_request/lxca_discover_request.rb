################################################################################
# <LENOVO COPYRIGHT TO BE INSERTED>
#
# <The below Apache License information to be reviewed by legal 
# and modified if need be>
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

Puppet::Type.type(:lxca_discover_request).provide(:lxca_discover_request) do
  desc 'Discover request provider for LXCA resource'
  
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

  def discover_manageable_devices
    create_client if @client.nil?
    if @resource[:ip_addresses].nil?
      raise Puppet::Error, _("Attribute ip_addresses is mandatory for the ensurable discover_manageable_devices")
    end

    @client.discover_manageable_devices(@resource[:ip_addresses])
  end

  def monitor_discover_request
    create_client if @client.nil?
    if @resource[:job_id].nil?
      raise Puppet::Error, _("Attribute job_id is mandatory for the ensurable monitor_discover_request")
    end

    @client.monitor_discover_request("#{@resource[:job_id]}").map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

end

