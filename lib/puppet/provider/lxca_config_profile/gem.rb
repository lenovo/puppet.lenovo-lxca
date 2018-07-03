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

Puppet::Type.type(:lxca_config_profile).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Configuration profile provider for LXCA resource'

  mk_resource_methods

  def self.instances
    instances = []
    config_profiles = Puppet::Provider::Lxca.discover_all_config_profiles

    return [] if config_profiles.nil?
    config_profiles.each do |item|
      item = item.to_hash
      Puppet.debug('config profile id is ' + item['id'].to_s)
      instances << new(ensure: :present,
                       id: item['id'],
                       name: item['id'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    config_profiles = instances
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = config_profiles.find { |item| item.name == name }
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
    Puppet.debug('provider I am inside destroy' + resource[:id].to_s)
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory when ensure is set to delete_config_profile')
    end
    Puppet::Provider::Lxca.delete_config_profile(@resource[:id])
    @property_hash.clear
  end

  def discover_all
    Puppet::Provider::Lxca.discover_all_config_profiles().map do |profile|
      profile.instance_variables.each do |att|
        puts "#{att} - #{profile.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :discover_all
  end

  def filter_by_id
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory for the ensurable filter_by_uuid')
    end
    Puppet::Provider::Lxca.fetch_config_profile([(@resource[:id]).to_s]).map do |profile|
      profile.instance_variables.each do |att|
        puts "#{att} - #{profile.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :filter_by_id
  end

  def rename_config_profile
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable rename_config_profile')
    end
    if @resource[:profile_name].nil?
      raise Puppet::Error, _('Attribute profile_name is mandatory for the ensurable rename_config_profile')
    end
    Puppet::Provider::Lxca.rename_config_profile((@resource[:id]).to_s, (@resource[:profile_name]).to_s)
  end

  def activate_config_profile
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable activate_config_profile')
    end
    if @resource[:endpoint_uuid].nil?
      raise Puppet::Error, _('Attribute endpoint_uuid is mandatory for the ensurable activate_config_profile')
    end
    if @resource[:restart].nil?
      raise Puppet::Error, _('Attribute restart is mandatory for the ensurable activate_config_profile')
    end

    Puppet::Provider::Lxca.activate_config_profile((@resource[:id]).to_s, (@resource[:endpoint_uuid]).to_s, (@resource[:restart]).to_s)
  end

  def unassign_config_profile
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:power_down].nil?
      raise Puppet::Error, _('Attribute power_down is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:reset_imm].nil?
      raise Puppet::Error, _('Attribute reset_imm is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:force].nil?
      raise Puppet::Error, _('Attribute force is mandatory for the ensurable unassign_config_profile')
    end

    Puppet::Provider::Lxca.unassign_config_profile((@resource[:id]).to_s, (@resource[:power_down]).to_s, (@resource[:reset_imm]).to_s, (@resource[:force]).to_s)
  end

end
