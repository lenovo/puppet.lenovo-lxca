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

Puppet::Type.newtype(:lxca_node) do
  apply_to_all
  ensurable do
    defaultvalues
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA node elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:discover_managed) do
      Puppet.notice "Fetching all the LXCA managed node elements. Results displayed below\n"
      provider.discover_managed_nodes
    end

    newvalue(:discover_unmanaged) do
      Puppet.notice "Fetching all the LXCA unmanaged node elements. Results displayed below\n"
      provider.discover_unmanaged_nodes
    end

    newvalue(:filter_by_chassis) do
      Puppet.notice "Fetching all the LXCA node elements filtered by chassis. Results displayed below\n"
      provider.filter_by_chassis
    end

    newvalue(:filter_by_uuid) do
      Puppet.notice "Fetching LXCA node filtered by UUID. Results displayed below\n"
      provider.filter_by_uuid
    end

    newvalue(:power_on) do
      Puppet.notice 'Powering on the node'
      provider.power_on
    end

    newvalue(:power_off) do
      Puppet.notice 'Powering off the node'
      provider.power_off
    end

    newvalue(:power_restart) do
      Puppet.notice 'Restarting the node'
      provider.power_restart
    end

    newvalue(:blink_led) do
      Puppet.notice 'Blinking the led on the node'
      provider.blink_led
    end

    newvalue(:turn_on_led) do
      Puppet.notice 'Turning on led on the node'
      provider.turn_on_led
    end

    newvalue(:turn_off_led) do
      Puppet.notice 'Turning off the led on the node'
      provider.turn_off_led
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca node resource'
  end

  newparam(:uuid) do
    desc 'UUID of the node'

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
