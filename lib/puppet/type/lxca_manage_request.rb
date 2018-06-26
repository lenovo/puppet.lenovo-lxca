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

Puppet::Type.newtype(:lxca_manage_request) do
  apply_to_all
  # ensurable
  ensurable do
    newvalue(:fetch_manage_request) do
      Puppet.notice "Monitor the status of a management request using the job id. Results are displayed below\n"
      provider.fetch_manage_request
    end

    newvalue(:manage_discovered_devices) do
      Puppet.notice 'Manage devices that have been discovered. The response header includes a URI that is associated with a job that indicates that a task was started.'
      provider.manage_discovered_devices
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca manage request resource'
  end

  newparam(:ip_address) do
    desc 'Specifies the IP address of the device to be managed.'
  end

  newparam(:username) do
    desc 'The user ID to be used to access the device.'
  end

  newparam(:password) do
    desc 'The current password to access the device.'
  end

  newparam(:recovery_password) do
    desc 'The recovery password to be used for the device.'
  end

  newparam(:force) do
    desc 'Indicates whether the force management of the device even if it is already managed by another Lenovo XClarity Administrator instance.'
  end

  newparam(:job_id) do
    desc 'Job ID that was returned by the POST /manageRequest method and using which the manage request needs to be fetched.'
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
