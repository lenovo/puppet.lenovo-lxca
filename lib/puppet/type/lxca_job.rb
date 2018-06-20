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

Puppet::Type.newtype(:lxca_job) do
  apply_to_all
  #ensurable
  ensurable do
    newvalue(:cancel_job) do
      Puppet.notice "Cancelling the job"
      provider.cancel_job
    end

    newvalue(:present) do
      Puppet.notice "In present the job"
    end

    newvalue(:absent) do
      Puppet.notice "In absent the job"
      provider.destroy
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name for the lxca job resource'
  end

  newparam(:uuid) do
    desc 'UUID of the device associated with which the jobs are to be fetched'
  end

  newparam(:id) do
    desc 'ID of the job on which filtering is to be applied'
  end

  newparam(:state) do
    desc 'State of the job based on which the list of jobs is to be filtered'
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
