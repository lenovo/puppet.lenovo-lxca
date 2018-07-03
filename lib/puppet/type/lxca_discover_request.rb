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

Puppet::Type.newtype(:lxca_discover_request) do
  apply_to_all
  ensurable do
    newvalue(:discover_manageable_devices) do
      Puppet.notice 'A POST job gets started to discover manageable devices. The response header includes a URI that is associated with a job that indicates that a task was started.'
      provider.discover_manageable_devices
    end

    newvalue(:monitor_discover_request) do
      Puppet.notice "Monitor the status of a discovery request. The results are as displayed below\n"
      provider.monitor_discover_request
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca discover request resource'
  end

  newparam(:ip_addresses) do
    desc 'One or more IP addresses for each device to be discovered.'

    validate do |value|
      super value
      raise('the ip address must be string representation of ip address') if value.size > 11
    end
  end

  newparam(:job_id) do
    desc 'Job ID that was returned by the POST /discoverRequest method and using which the discover request needs to be monitored.'
  end

  validate do
    required_parameters = [
    ]
    required_parameters.each do |param|
      if param.nil? || param == ''
        raise Puppet::Error, _("Attribute #{param} is mandatory and should not be empty")
      end
    end
  end
end
