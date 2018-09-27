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

require 'puppet/type'
require File.join(File.dirname(__FILE__), '../lxca')
require 'json'

Puppet::Type.type(:lxca_node).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'nodes provider for LXCA resource'

  mk_resource_methods

  def self.instances
    instances = []
    nodes = Puppet::Provider::Lxca.discover_all_nodes

    return [] if nodes.nil?
    nodes.each do |item|
      item = item.to_hash
      Puppet.debug('node uuid is ' + item['uuid'].to_s)
      instances << new(ensure: :present,
                       uuid: item['uuid'],
                       name: item['uuid'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    nodes = instances
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = nodes.find { |item| item.name == name }
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
    Puppet.debug('provider I am inside destroy' + resource[:uuid].to_s)
    @property_hash.clear
  end

  def discover_all
    Puppet::Provider::Lxca.discover_all_nodes().map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :discover_all
  end

  def discover_managed_nodes
    Puppet::Provider::Lxca.discover_managed_nodes().map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :discover_managed
  end

  def discover_unmanaged_nodes
    Puppet::Provider::Lxca.discover_unmanaged_chassis().map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :discover_unmanaged
  end

  def filter_by_uuid
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory for the ensurable filter_by_uuid')
    end
    Puppet::Provider::Lxca.filter_nodes_by_uuid([(@resource[:uuid]).to_s]).map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
    @property_hash[:ensure] == :filter_by_uuid
  end

  def filter_by_chassis
    if @resource[:chassis].nil?
      raise Puppet::Error, _('Attribute chassis is mandatory for the ensurable filter_by_chassis')
    end
    Puppet::Provider::Lxca.filter_nodes_by_chassis(chassis: (@resource[:chassis]).to_s).map do |node|
      node.instance_variables.each do |att|
        puts "#{att} - #{node.instance_variable_get att}"
      end
    end
  end

  def power_on
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to power_on')
    end
    Puppet::Provider::Lxca.power_on_node(@resource[:uuid])
  end

  def power_off
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to power_off')
    end
    Puppet::Provider::Lxca.power_off_node(@resource[:uuid])
  end

  def power_restart
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to power_restart')
    end
    Puppet::Provider::Lxca.power_restart_node(@resource[:uuid])
  end

  def blink_led
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to blink_led')
    end
    Puppet::Provider::Lxca.blink_loc_led(@resource[:uuid])
  end

  def turn_on_led
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to turn_on_led')
    end
    Puppet::Provider::Lxca.turn_on_loc_led(@resource[:uuid])
  end

  def turn_off_led
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory when ensure is set to turn_off_led')
    end
    Puppet::Provider::Lxca.turn_off_loc_led(@resource[:uuid])
  end
end
