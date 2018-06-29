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

Puppet::Type.type(:lxca_discover_request).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage jobs on Lenovo LXCA. Requires xclarity_client'

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

  def exists?
    Puppet.debug('I am inside exists')
    @property_hash[:ensure] == :present
  end

  def destroy
    Puppet.debug('provider I am inside destroy' + resource[:id].to_s)
    @property_hash.clear
  end

  def discover_manageable_devices
    if @resource[:ip_addresses].nil?
      raise Puppet::Error, _('Attribute ip_addresses is mandatory for the ensurable discover_manageable_devices')
    end

    Puppet::Provider::Lxca.discover_manageable_devices(@resource[:ip_addresses])
  end

  def monitor_discover_request
    if @resource[:job_id].nil?
      raise Puppet::Error, _('Attribute job_id is mandatory for the ensurable monitor_discover_request')
    end

    Puppet::Provider::Lxca.monitor_discover_request((@resource[:job_id]).to_s).map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end
end
