# Copyright (c) 2017, Lenovo. All rights reserved.
#
# This program and the accompanying materials are licensed and made available
# under the terms and conditions of the 3-clause BSD License that accompanies
# this distribution. The full text of the license may be found at
#
# https://opensource.org/licenses/BSD-3-Clause
#
# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.

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
