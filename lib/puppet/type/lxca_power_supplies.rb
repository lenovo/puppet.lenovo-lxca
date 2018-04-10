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

Puppet::Type.newtype(:lxca_power_supplies) do
  ensurable do
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA power supply elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:filter_by_chassis) do
      Puppet.notice "Fetching all the LXCA power supply elements filtered by chassis. Results displayed below\n"
      provider.filter_by_chassis
    end

    newvalue(:filter_by_uuid) do
      Puppet.notice "Fetching LXCA power supplies filtered by UUID. Results displayed below\n"
      provider.filter_by_uuid
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca power supply resource'
  end

  newparam(:host) do
    desc 'LXCA Host to connect to'
  end

  newparam(:port) do
    desc 'Port of LXCA to connect to'
  end

  newparam(:login_user) do
    desc 'The username to be used to login into LXCA'
  end

  newparam(:login_password) do
    desc 'The password to be used to login into LXCA'
  end

  newparam(:verify_ssl) do
    desc 'Whether to verify SSL when connecting to the LXCA'
  end

  newparam(:auth_type) do
    desc 'The authorization type used to connect to LXCA. Defaults to basic_auth'
    defaultto 'basic_auth'
  end

  newparam(:csrf_token) do
    desc 'The CSRF token to be used in case authentication type is set to token'
  end

  newparam(:uuid) do
    desc 'UUID of the power supply'
  end

  newparam(:chassis) do
    desc 'UUID of the chassis on which filtering is to be applied'
  end

  validate do
    required_parameters = [
      :host,
      :port,
      :login_user,
      :login_password,
      :verify_ssl,
    ]
    required_parameters.each do |param|
      if param.nil? || param == ''
        raise Puppet::Error, _("Attribute #{param} is mandatory and should not be empty")
      end
    end
  end
end
