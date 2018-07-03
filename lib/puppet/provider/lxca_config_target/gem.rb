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

Puppet::Type.type(:lxca_config_target).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Config target resource on Lenovo LXCA. Requires xclarity_client'

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

  def filter_by_id
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable filter_by_id')
    end

    Puppet::Provider::Lxca.fetch_config_target([(@resource[:id]).to_s]).map do |target|
      target.instance_variables.each do |att|
        puts "#{att} - #{target.instance_variable_get att}"
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
