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

Puppet::Type.newtype(:lxca_update_comp) do
  apply_to_all
  ensurable do
    newvalue(:discover_firmware_update_status) do
      Puppet.notice "Discover firmware update status. Results are displayed below\n"
      provider.discover_firmware_update_status
    end

    newvalue(:discover_updatable_device_comp) do
      Puppet.notice "Discover updatable components. Results are displayed below\n"
      provider.discover_updatable_device_comp
    end

    newvalue(:apply_firmware_update) do
      Puppet.notice "Apply firmware update. Results are displayed below\n"
      provider.apply_firmware_update
    end

    newvalue(:cancel_firmware_update) do
      Puppet.notice "Cancel firmware update job. Results are displayed below\n"
      provider.cancel_firmware_update
    end
    newvalue(:modify_power_state) do
      Puppet.notice "Modify power state. Results are displayed below\n"
      provider.modify_power_state
    end
  end

  newparam(:name, namevar: true) do
    desc 'Name of the lxca firmware request resource'
  end

  newparam(:activation_mode) do
    desc 'Information about when to activate the update on device.'

    validate do |value|
      super value
      unless %w[immediate delayed].any? { |option| value.include? option }
        raise('The valid values are: immediate delayed')
      end
    end
  end

  newparam(:force_update_mode) do
    desc 'Indicates whether to apply the update if firmware is already compliant.'
  end

  newparam(:on_error_mode) do
    desc 'Indicates how to handle errors during the firmware update.
          default value is stopdeviceOnError .'

    validate do |value|
      super value
      unless %w[stopOnError stopdeviceOnError continueOnError].any? { |option| value.include? option }
        raise('The valid values are: immediate delayed')
      end
    end
  end

  newparam(:server) do
    desc 'Information about server device and firmware update to be applied, specified as an Array.'
  end

  newparam(:switch) do
    desc 'Information about switch device and firmware update to be applied, specified as an Array.'
  end

  newparam(:storage) do
    desc 'Information about storage device and firmware update to be applied, specified as an Array.'
  end

  newparam(:cmm) do
    desc 'Information about cmm device and firmware update to be applied, specified as an Array.'
  end
end
