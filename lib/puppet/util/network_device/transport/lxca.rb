################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2018.
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

require 'puppet/util/network_device'
require 'puppet/util/network_device/transport'
require 'puppet/util/network_device/transport/base'
require 'xclarity_client'

# implements network transport
class Puppet::Util::NetworkDevice::Transport::Lxca < Puppet::Util::NetworkDevice::Transport::Base
  attr_reader :connection

  def initialize(url, _options = {})
    Puppet.debug("url = #{url}")

    array = url.split(%r{:})
    transport = array[0]
    username = array[1]
    username = username[2, username.length]
    innerarray = array[2].split(%r{@})
    password = innerarray[0]
    lxca_ip = innerarray[1]
    lxca_ip = lxca_ip[0, lxca_ip.length - 1] if lxca_ip.chars.last == '/'
    portnumber = '443'
    # if array [3] != nil
    unless array[3].nil
      portnumber = array [3]
      if portnumber.chars.last == '/'
        portnumber = portnumber[0, portnumber.length - 1]
      end
    end
    params = {}
    params['port'] = portnumber
    params['host'] = transport + '://' + lxca_ip
    params['username'] = username
    params['password'] = password
    params['auth_type'] = 'basic_auth'
    params['verify_ssl'] = 'NONE'
    params['user_agent_label'] = 'Ruby'
    # @connection = Connect.new(params)
    conf = XClarityClient::Configuration.new(params)

    @connection = XClarityClient::Client.new(conf)
    Puppet.debug("In initialize connection = #{@connection.inspect}")
  end

  def call(_url, args = {})
    Puppet.debug("connection = #{@connection.inspect}")
    @connection.discover_aicc(args)
  end

  def failure?(result)
    unless result.status == 200
      raise("REST failure: HTTP status code #{result.status} detected.  Body of failure is: #{result.body}")
    end
  end

  def post(url, json)
    if valid_json?(json)
      result = connection.post do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
      failure?(result)
      result
    else
      raise('Invalid JSON detected.')
    end
  end

  def put(url, json)
    if valid_json?(json)
      result = connection.put do |req|
        req.url url
        req.headers['Content-Type'] = 'application/json'
        req.body = json
      end
      failure?(result)
      result
    else
      raise('Invalid JSON detected.')
    end
  end

  def delete(url)
    result = connection.delete(url)
    failure?(result)
    result
  end

  def valid_json?(json)
    JSON.parse(json)
    return true
  rescue
    return false
  end
end
