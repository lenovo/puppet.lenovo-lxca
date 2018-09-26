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

Puppet::Type.type(:lxca_update_comp).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Update firmware on device on Lenovo LXCA. Requires xclarity_client'

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

  def discover_firmware_update_status
    Puppet::Provider::Lxca.discover_firmware_update_status.map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def discover_updatable_device_comp
    Puppet::Provider::Lxca.discover_updatable_device_comp.map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def apply_firmware_update
    Puppet::Provider::Lxca.apply_firmware_update(@resource[:activation_mode],
                                                 @resource[:force_update_mode],
                                                 @resource[:on_error_mode],
                                                 @resource[:server],
                                                 @resource[:switch],
                                                 @resource[:storage],
                                                 @resource[:cmm]).map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def cancel_firmware_update
    Puppet::Provider::Lxca.cancel_firmware_update(@resource[:server],
                                                  @resource[:switch],
                                                  @resource[:storage],
                                                  @resource[:cmm]).map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def modify_power_state
    Puppet::Provider::Lxca.modify_power_state(@resource[:server],
                                              @resource[:switch],
                                              @resource[:storage],
                                              @resource[:cmm]).map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def exists?
    Puppet.debug('I am inside exists')
  end

  def destroy
    Puppet.debug('I am inside destroy' + resource[:id].to_s)
  end
end
