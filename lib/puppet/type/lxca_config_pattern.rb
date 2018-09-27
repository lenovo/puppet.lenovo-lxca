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

Puppet::Type.newtype(:lxca_config_pattern) do
  apply_to_all
  ensurable do
    defaultvalues
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA configuration pattern elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:filter_by_id) do
      Puppet.notice "Fetching all the LXCA configuration pattern elements filtered by id of the pattern. Results displayed below\n"
      provider.filter_by_id
    end

    newvalue(:export_config_pattern) do
      Puppet.notice 'Exporting the configuration pattern'
      provider.export_config_pattern
    end

    newvalue(:import_config_pattern) do
      Puppet.notice 'Importing a configuration pattern'
      provider.import_config_pattern
    end

    newvalue(:deploy_config_pattern) do
      Puppet.notice 'Deploy a configuration pattern'
      provider.deploy_config_pattern
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name for the lxca configuration pattern resource'
  end

  newparam(:id) do
    desc 'ID of the configuration pattern on which an operation is to be performed'
  end

  newparam(:endpoints) do
    desc 'A list of one or more UUIDs for the target servers, empty chassis bay, or placeholder chassis bay'
  end

  newparam(:restart) do
    desc 'Identifies when to activate the configurations. The valid values are: defer, immediate, pending'
    validate do |value|
      super value
      unless %w[defer immediate pending].any? { |option| value.include? option }
        raise(' The valid values are: defer, immediate, pending')
      end
    end
  end

  newparam(:etype) do
    desc 'Identified whether the endpoint on which a configuration pattern is to be deployed is a node, rack or a tower.'

    validate do |value|
      super value
      unless %w[node rack tower].any? { |option| value.include? option }
        raise('The valid values are: node, rack, tower')
      end
    end
  end

  newparam(:import_json) do
    desc 'A correctly formatted JSON of the configuration pattern that needs to be imported.'
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
