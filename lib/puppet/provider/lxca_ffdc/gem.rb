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

Puppet::Type.type(:lxca_ffdc).provide(:gem, parent: Puppet::Provider::Lxca) do
  desc 'Ffdc provider for LXCA resource'

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

  def filter_by_uuid
    create_client if @client.nil?
    if @resource[:uuid].nil?
      raise Puppet::Error, _('Attribute uuid is mandatory for the ensurable filter_by_uuid')
    end

    Puppet::Provider::Lxca.fetch_ffdc([(@resource[:uuid]).to_s]).map do |ffdc|
      ffdc.instance_variables.each do |att|
        puts "#{att} - #{ffdc.instance_variable_get att}"
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
