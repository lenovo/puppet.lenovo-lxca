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

Puppet::Type.type(:lxca_job).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage jobs on Lenovo LXCA. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    jobs = Puppet::Provider::Lxca.get_all_jobs

    Puppet.debug('I am inside instances jobs = #{jobs}')
    return [] if jobs.nil?
    jobs.each do |item|
      item = item.to_hash
      Puppet.debug('Job Id is ' + item['id'].to_s)
      Puppet.debug('Job name is ' + item['displayMessage'].to_s)
      Puppet.debug('Job uuid is ' + item['uuid'].to_s)
      Puppet.debug('Job state is ' + item['state'].to_s)
      instances << new(ensure: :present,
                       uuid: item['uuid'],
                       name: item['id'],
                       state: item['state'],
                       id: item['id'].to_s)
    end
    instances
  end

  def self.prefetch(resources)
    Puppet.debug('I am inside prefetch')
    jobs = instances
    Puppet.debug('prefetch jobs ' + jobs.to_s)
    Puppet.debug('prefetch resource ' + resources.to_s)
    Puppet.debug('prefetch resource keys' + resources.keys.to_s)
    resources.keys.each do |name|
      if provider = jobs.find { |job| job.name == name }
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
    Puppet::Provider::Lxca.delete_job(resource[:id])
  end
end
