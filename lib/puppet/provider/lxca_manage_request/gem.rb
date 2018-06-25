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

Puppet::Type.type(:lxca_manage_request).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage devices  on Lenovo LXCA. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    instances
  end

  def self.prefetch(resources)
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
      raise Puppet::Error, _("Attribute job_id is mandatory for the ensurable fetch_manage_request")
    end

    Puppet::Provider::Lxca.fetch_manage_request("#{@resource[:job_id]}").map do |req|
      req.instance_variables.each do |attr|
        puts "#{attr} - #{req.instance_variable_get attr}"
      end
    end
  end

  def manage_discovered_devices
    if @resource[:ip_address].nil?
      raise Puppet::Error, _("Attribute ip_address is mandatory for the ensurable manage_discovered_devices")
    end
    if @resource[:username].nil?
      raise Puppet::Error, _("Attribute username is mandatory for the ensurable manage_discovered_devices")
    end
    if @resource[:password].nil?
      raise Puppet::Error, _("Attribute password is mandatory for the ensurable manage_discovered_devices")
    end
    if @resource[:recovery_password].nil?
      raise Puppet::Error, _("Attribute recovery_password is mandatory for the ensurable manage_discovered_devices")
    end
    if @resource[:force].nil?
      raise Puppet::Error, _("Attribute force is mandatory for the ensurable manage_discovered_devices")
    end

    Puppet::Provider::Lxca.manage_discovered_devices(@resource[:ip_address], "#{@resource[:username]}", "#{@resource[:password]}", "#{@resource[:recovery_password]}", "#{@resource[:force]}")
  end

  def exists?
    Puppet.debug('I am inside exists')
  end

  def destroy
    Puppet.debug('I am inside destroy' + resource[:id].to_s)
  end
end
