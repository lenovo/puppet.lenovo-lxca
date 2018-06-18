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

Puppet::Type.type(:lxca_users).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage Users on Lenovo LXCA. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    users = Puppet::Provider::Lxca.get_all_users

    Puppet.debug('I am inside instances users = #{users}')
    return [] if users.nil?
    users.each do |item|
      item = item.to_hash
      Puppet.debug('User Id is ' + item['id'].to_s)
      Puppet.debug('User name is ' + item['userName'].to_s)
      instances << new(ensure: :present,
                       name: item['userName'],
                       id: item['id'].to_s)
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    users = instances
    Puppet.debug('prefetch users ' + users.to_s)
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = users.find { |user| user.name == name }
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
  end

  def destroy
    Puppet.debug('I am inside destroy' + resource[:id].to_s)
  end
end
