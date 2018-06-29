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

Puppet::Type.type(:lxca_event).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Event provider for LXCA resource. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    events = Puppet::Provider::Lxca.discover_events
    return [] if events.nil?
    events.each do |item|
      item = item.to_hash
      Puppet.debug('event uuid is ' + item['uuid'].to_s)
      instances << new(ensure: :present,
                       msg: item['msg'],
                       name: item['msg'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    events = instances
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = events.find { |item| item.name == name }
        Puppet.debug("Prefetch data coming here is #{provider}")
        resources[name].provider = provider
      end
    end
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
    Puppet.debug('provider I am inside destroy')
    @property_hash.clear
  end

  def discover_all
    Puppet::Provider::Lxca.discover_events.map do |event|
      event.instance_variables.each do |att|
        puts "#{att} - #{event.instance_variable_get att}"
      end
    end
  end

end
