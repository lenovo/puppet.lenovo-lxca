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

Puppet::Type.type(:lxca_config_pattern).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Configuration pattern provider for LXCA resource'

  mk_resource_methods

  def self.instances
    instances = []
    config_patterns = Puppet::Provider::Lxca.discover_all_config_paterns

    return [] if config_patterns.nil?
    config_patterns.each do |item|
      item = item.to_hash
      Puppet.debug('config pattern id is ' + item['id'].to_s)
      instances << new(ensure: :present,
                       id: item['id'],
                       name: item['id'])
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    config_patterns = instances
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = config_patterns.find { |item| item.name == name }
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
    @property_hash.clear
  end

  def filter_by_id
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable filter_by_id')
    end
    Puppet::Provider::Lxca.fetch_config_pattern([(@resource[:id]).to_s]).map do |pattern|
      pattern.instance_variables.each do |att|
        puts "#{att} - #{pattern.instance_variable_get att}"
      end
    end
  end

  def export_config_pattern
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable export_config_pattern')
    end

    Puppet::Provider::Lxca.export_config_pattern((@resource[:id]).to_s).map do |pattern|
      pattern.instance_variables.each do |att|
        puts "#{att} - #{pattern.instance_variable_get att}"
      end
    end
  end

  def deploy_config_pattern
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable deploy_config_pattern')
    end
    if @resource[:endpoints].nil?
      raise Puppet::Error, _('Attribute endpoints is mandatory for the ensurable deploy_config_pattern')
    end
    if @resource[:restart].nil?
      raise Puppet::Error, _('Attribute restart is mandatory for the ensurable deploy_config_pattern')
    end
    if @resource[:etype].nil?
      raise Puppet::Error, _('Attribute etype is mandatory for the ensurable deploy_config_pattern')
    end

    Puppet::Provider::Lxca.deploy_config_pattern((@resource[:id]).to_s, (@resource[:endpoints]).to_s, (@resource[:restart]).to_s, (@resource[:etype]).to_s)
  end

  def import_config_pattern
    if @resource[:import_json].nil?
      raise Puppet::Error, _('Attribute import_json is mandatory for the ensurable import_config_pattern')
    end

    Puppet::Provider::Lxca.import_config_pattern((@resource[:import_json]).to_s)
  end
end
