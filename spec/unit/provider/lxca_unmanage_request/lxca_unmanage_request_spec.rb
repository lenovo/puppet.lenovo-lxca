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

require 'spec_helper'

describe Puppet::Type.type(:lxca_unmanage_request).provider(:lxca_unmanage_request) do
  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_unmanage_request).stubs(:defaultprovider).returns described_class
  end

  let :unmanage_request do
    Puppet::Type.type(:lxca_unmanage_request).new(
      name: 'lxca_unmanage_request',
      host: 'https://10.243.13.140',
      port: '443',
      login_user: 'USERID',
      login_password: 'Passw0rd',
      verify_ssl: 'NONE',
    )
  end

  let :unmanage_request_with_endpoints do
    Puppet::Type.type(:lxca_unmanage_request).new(
      name: 'lxca_unmanage_request',
      host: 'https://10.243.13.140',
      port: '443',
      login_user: 'USERID',
      login_password: 'Passw0rd',
      verify_ssl: 'NONE',
      endpoints: [{ 'ipAddresses' => ['10.243.8.28'], 'type' => 'Chassis', 'uuid' => '792812BA57B24337821B72AC27CF2055' }],
      force: 'False',
    )
  end

  let :unmanage_request_without_force do
    Puppet::Type.type(:lxca_unmanage_request).new(
      name: 'lxca_unmanage_request',
      host: 'https://10.243.13.140',
      port: '443',
      login_user: 'USERID',
      login_password: 'Passw0rd',
      verify_ssl: 'NONE',
      endpoints: [{ 'ipAddresses' => ['10.243.8.28'], 'type' => 'Chassis', 'uuid' => '792812BA57B24337821B72AC27CF2055' }],
    )
  end

  let :unmanage_request_with_job_id do
    Puppet::Type.type(:lxca_unmanage_request).new(
      name: 'lxca_unmanage_request',
      host: 'https://10.243.13.140',
      port: '443',
      login_user: 'USERID',
      login_password: 'Passw0rd',
      verify_ssl: 'NONE',
      job_id: '1234',
    )
  end

  describe 'provider instance type' do
    it 'with endpoints should be an instance of provider ruby' do
      expect(unmanage_request_with_endpoints.provider).to be_an_instance_of Puppet::Type.type(:lxca_unmanage_request).provider(:lxca_unmanage_request)
    end

    it 'with job_id should be an instance of provider ruby' do
      expect(unmanage_request_with_job_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_unmanage_request).provider(:lxca_unmanage_request)
    end
  end

  describe 'for ensurable unmanage_discovered_devices' do
    it 'has endpoints as a parameter' do
      expect { unmanage_request.provider.unmanage_discovered_devices }.to raise_error(Puppet::Error, %r{Attribute endpoints is mandatory for the ensurable unmanage_discovered_devices})
    end

    it 'has force as a parameter' do
      expect { unmanage_request_without_force.provider.unmanage_discovered_devices }.to raise_error(Puppet::Error, %r{Attribute force is mandatory for the ensurable unmanage_discovered_devices})
    end
  end

  describe 'for ensurable unmanage_discovered_devices' do
    it 'response should have location' do
      expect(unmanage_request_with_endpoints.provider.unmanage_discovered_devices.headers).to include 'location'
    end
  end

  describe 'for ensurable fetch_unmanage_request' do
    it 'has job_id as a parameter' do
      expect { unmanage_request.provider.fetch_unmanage_request }.to raise_error(Puppet::Error, %r{Attribute job_id is mandatory for the ensurable fetch_unmanage_request})
    end
  end

  describe 'for ensurable fetch_unmanage_request' do
    it 'returns an array as a result' do
      expect(unmanage_request_with_job_id.provider.fetch_unmanage_request).to be_instance_of(Array)
    end
  end
end
