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

require 'puppet/type'
require File.join(File.dirname(__FILE__), '../lxca')
require 'json'

Puppet::Type.type(:lxca_manage_request).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage devices  on Lenovo LXCA. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    instances
  end

  def self.prefetch(_resources)
    Puppet.debug('I am inside prefetch')
  end

  def flush
    Puppet.debug('I am inside flush')
  end

  def create
    Puppet.notice('I am inside create')
  end

  def fetch_manage_request
    if @resource[:job_id].nil?
      raise Puppet::Error, _('Attribute job_id is mandatory for the ensurable fetch_manage_request')
    end

    Puppet::Provider::Lxca.fetch_manage_request((@resource[:job_id]).to_s).map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def manage_discovered_devices
    if @resource[:ip_address].nil?
      raise Puppet::Error, _('Attribute ip_address is mandatory for the ensurable manage_discovered_devices')
    end
    if @resource[:username].nil?
      raise Puppet::Error, _('Attribute username is mandatory for the ensurable manage_discovered_devices')
    end
    if @resource[:password].nil?
      raise Puppet::Error, _('Attribute password is mandatory for the ensurable manage_discovered_devices')
    end
    if @resource[:recovery_password].nil?
      raise Puppet::Error, _('Attribute recovery_password is mandatory for the ensurable manage_discovered_devices')
    end
    if @resource[:force].nil?
      raise Puppet::Error, _('Attribute force is mandatory for the ensurable manage_discovered_devices')
    end

    Puppet::Provider::Lxca.manage_discovered_devices(@resource[:ip_address], (@resource[:username]).to_s, (@resource[:password]).to_s, (@resource[:recovery_password]).to_s, (@resource[:force]).to_s)
  end

  def exists?
    Puppet.debug('I am inside exists')
  end

  def destroy
    Puppet.debug('I am inside destroy' + resource[:id].to_s)
  end
end
