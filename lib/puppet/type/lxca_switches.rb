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

Puppet::Type.newtype(:lxca_switches) do
  apply_to_all
  ensurable do
    defaultvalues
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA switch elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:filter_by_chassis) do
      Puppet.notice "Fetching all the LXCA switch elements filtered by chassis. Results displayed below\n"
      provider.filter_by_chassis
    end

    newvalue(:filter_by_uuid) do
      Puppet.notice "Fetching LXCA switch filtered by UUID. Results displayed below\n"
      provider.filter_by_uuid
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca switch resource'
  end

  newparam(:uuid) do
    desc 'UUID of the switch'

    validate do |value|
      super value
      raise('the uuid must be string of lenth 16 ') if value.size < 16
    end
  end

  newparam(:chassis) do
    desc 'UUID of the chassis on which filtering is to be applied'

    validate do |value|
      super value
      raise('the uuid must be string of lenth 16 ') if value.size < 16
    end
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
