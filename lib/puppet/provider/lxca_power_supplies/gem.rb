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

Puppet::Type.type(:lxca_power_supplies).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Power supply provider for LXCA resource'

  mk_resource_methods

  def self.instances
    instances = []
    power_supplies = Puppet::Provider::Lxca.discover_all_power_supplies

    return [] if power_supplies.nil?
    power_supplies.each do |item|
      item = item.to_hash
      Puppet.debug('power_supply uuid is ' + item['uuid'].to_s)
      instances << new(ensure: :present,
                       uuid: item['uuid'],
                       name: item['uuid'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    power_supplies = instances
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = power_supplies.find { |item| item.name == name }
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
    Puppet::Provider::Lxca.discover_all_power_supplies.map do |power_supply|
      power_supply.instance_variables.each do |att|
        puts "#{att} - #{power_supply.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :discover_all
  end

  def filter_by_chassis
    if @resource[:chassis].nil?
      raise Puppet::Error, _('Attribute chassis is mandatory for the ensurable filter_by_chassis')
    end
    Puppet::Provider::Lxca.filter_power_supplies_by_chassis(chassis: (@resource[:chassis]).to_s).map do |power_supply|
      power_supply.instance_variables.each do |att|
        puts "#{att} - #{power_supply.instance_variable_get att}"
      end
    end
    #@property_hash[:ensure] == :filter_by_chassis
  end

  def filter_by_uuid
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory for the ensurable filter_by_uuid')
    end
    Puppet::Provider::Lxca.filter_power_supplies_by_uuid([(@resource[:uuid]).to_s]).map do |power_supply|
      power_supply.instance_variables.each do |att|
        puts "#{att} - #{power_supply.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :filter_by_uuid
  end
end
