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

Puppet::Type.newtype(:lxca_config_profile) do
  apply_to_all
  ensurable do
    defaultvalues
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA configuration profile elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:filter_by_id) do
      Puppet.notice "Fetching all the LXCA configuration profile elements filtered by id of the profile. Results displayed below\n"
      provider.filter_by_id
    end

    newvalue(:rename_config_profile) do
      Puppet.notice 'Renaming the configuration profile'
      provider.rename_config_profile
    end

    newvalue(:activate_config_profile) do
      Puppet.notice 'Activate a configuration profile'
      provider.activate_config_profile
    end

    newvalue(:unassign_config_profile) do
      Puppet.notice 'Unassign a configuration profile'
      provider.unassign_config_profile
    end

    newvalue(:delete_config_profile) do
      Puppet.notice 'Deleting the configuration profile'
      provider.delete_config_profile
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name for the lxca configuration profile resource'
  end

  newparam(:id) do
    desc 'ID of the configuration profile on which an operation is to be performed'
  end

  newparam(:profile_name) do
    desc 'New name for the configuration profile'
  end

  newparam(:endpoint_uuid) do
    desc 'For a rack or tower server, this is the UUID of the server. For a Flex System server, this is the location ID on which the configuration profile has to be activated'
  end

  newparam(:restart) do
    desc 'Indicates when to restart the server to activate the profile. 2 values are allowed: immediate, defer'

    validate do |value|
      super value
      unless %w[defer immediatete].any? { |option| value.include? option }
        raise('The valid values are: defer, immediate')
      end
    end
  end

  newparam(:power_down) do
    desc 'A boolean value that indicates whether to power off the server when a configuration profile is deactivated'
  end

  newparam(:reset_imm) do
    desc 'A boolean value that indicates whether to reset the baseboard management controller when a configuration profile is deactivated'
  end

  newparam(:force) do
    desc 'A boolean value that indicates whether to force profile deactivation'
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
