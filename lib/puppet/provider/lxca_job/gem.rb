################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2016.
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

Puppet::Type.type(:lxca_job).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Manage jobs on Lenovo LXCA. Requires xclarity_client'

  mk_resource_methods

  def self.instances
    instances = []
    jobs = Puppet::Provider::Lxca.get_all_jobs

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
    @property_hash[:ensure] == :present
  end

  def destroy
    Puppet.debug('provider I am inside destroy' + resource[:id].to_s)
    Puppet::Provider::Lxca.delete_job(resource[:id])
    @property_hash.clear
  end

  def cancel_job
    Puppet.debug('Provider: I am inside cancel job' + resource[:id].to_s)
    Puppet::Provider::Lxca.cancel_job(resource[:id])
  end
end
