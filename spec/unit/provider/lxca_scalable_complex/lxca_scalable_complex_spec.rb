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

describe Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex) do
  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_scalable_complex).stubs(:defaultprovider).returns described_class
  end

  let :scalable_complex do
    Puppet::Type.type(:lxca_scalable_complex).new(
      name: 'lxca_scalable_complex',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
    )
  end

  let :scalable_complex_with_uuid do
    Puppet::Type.type(:lxca_scalable_complex).new(
      name: 'lxca_scalable_complex',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
      uuid: 'FA59C0BBC43C3C15B9D72B94AFF52B91',
    )
  end

  describe 'provider instance type' do
    it 'without uuid should be an instance of provider ruby' do
      expect(scalable_complex.provider).to be_an_instance_of Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex)
    end
    it 'with uuid should be an instance of provider ruby' do
      expect(scalable_complex_with_uuid.provider).to be_an_instance_of Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex)
    end
  end

  describe 'for ensurable filter_by_uuid' do
    it 'has uuid as a parameter' do
      expect { scalable_complex.provider.filter_by_uuid }.to raise_error(Puppet::Error, %r{Attribute uuid is mandatory for the ensurable filter_by_uuid})
    end
  end

  describe 'for discover_all' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe 'for discover_managed' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_managed_scalable_complex).to be_instance_of(Array)
    end
  end

  describe 'for discover_unmanaged' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_unmanaged_scalable_complex).to be_instance_of(Array)
    end
  end

  describe 'for discover_flex' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_flex).to be_instance_of(Array)
    end
  end

  describe 'for discover_rackserver' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_rackserver).to be_instance_of(Array)
    end
  end

  describe 'for filter_by_uuid' do
    it 'returns an array as a result' do
      expect(scalable_complex_with_uuid.provider.filter_by_uuid).to be_instance_of(Array)
    end
  end
end
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

describe Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex) do
  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_scalable_complex).stubs(:defaultprovider).returns described_class
  end

  let :scalable_complex do
    Puppet::Type.type(:lxca_scalable_complex).new(
      name: 'lxca_scalable_complex',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
    )
  end

  let :scalable_complex_with_uuid do
    Puppet::Type.type(:lxca_scalable_complex).new(
      name: 'lxca_scalable_complex',
      host: 'https://10.243.10.75',
      port: '443',
      login_user: 'Admin',
      login_password: 'Lenovo123',
      verify_ssl: 'NONE',
      uuid: 'FA59C0BBC43C3C15B9D72B94AFF52B91',
    )
  end

  describe 'provider instance type' do
    it 'without uuid should be an instance of provider ruby' do
      expect(scalable_complex.provider).to be_an_instance_of Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex)
    end
    it 'with uuid should be an instance of provider ruby' do
      expect(scalable_complex_with_uuid.provider).to be_an_instance_of Puppet::Type.type(:lxca_scalable_complex).provider(:lxca_scalable_complex)
    end
  end

  describe 'for ensurable filter_by_uuid' do
    it 'has uuid as a parameter' do
      expect { scalable_complex.provider.filter_by_uuid }.to raise_error(Puppet::Error, %r{Attribute uuid is mandatory for the ensurable filter_by_uuid})
    end
  end

  describe 'for discover_all' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe 'for discover_managed' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_managed_scalable_complex).to be_instance_of(Array)
    end
  end

  describe 'for discover_unmanaged' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_unmanaged_scalable_complex).to be_instance_of(Array)
    end
  end

  describe 'for discover_flex' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_flex).to be_instance_of(Array)
    end
  end

  describe 'for discover_rackserver' do
    it 'returns an array as a result' do
      expect(scalable_complex.provider.discover_rackserver).to be_instance_of(Array)
    end
  end

  describe 'for filter_by_uuid' do
    it 'returns an array as a result' do
      expect(scalable_complex_with_uuid.provider.filter_by_uuid).to be_instance_of(Array)
    end
  end
end
