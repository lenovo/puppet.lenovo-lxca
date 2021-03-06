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

Puppet::Type.newtype(:lxca_unmanage_request) do
  apply_to_all
  ensurable do
    newvalue(:fetch_unmanage_request) do
      Puppet.notice "Monitor the status of a unmanagement request using the job id. Results are displayed below\n"
      provider.fetch_unmanage_request
    end

    newvalue(:unmanage_discovered_devices) do
      Puppet.notice 'Unmanage one or more target devices. The response header includes a URI that is associated with a job that indicates that a task was started.'
      provider.unmanage_discovered_devices
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca unmanage request resource'
  end

  newparam(:endpoints) do
    desc 'Information about one or more devices to be unmanaged and specified as an Array.'
  end

  newparam(:force) do
    desc 'Indicates whether to force the unmanagement of the device.'
  end

  newparam(:job_id) do
    desc 'Job ID that was returned by the POST /unmanageRequest method and using which the unmanage request needs to be fetched.'
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
