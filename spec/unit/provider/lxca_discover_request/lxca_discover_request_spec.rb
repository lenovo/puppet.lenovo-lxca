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

describe Puppet::Type.type(:lxca_discover_request).provider(:lxca_discover_request) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_discover_request).stubs(:defaultprovider).returns described_class
  end

  let :discover_request do
    Puppet::Type.type(:lxca_discover_request).new(
      :name => 'lxca_discover_request',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
    )
  end

  let :discover_request_with_ip_addr do
    Puppet::Type.type(:lxca_discover_request).new(
      :name => 'lxca_discover_request',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_addresses => ['10.240.74.210'],
    )
  end

  let :discover_request_with_job_id do
    Puppet::Type.type(:lxca_discover_request).new(
      :name => 'lxca_discover_request',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :job_id => '3124',
    )
  end

  describe "provider instance type" do
    it "with ip_addresses should be an instance of provider ruby" do
      expect(discover_request_with_ip_addr.provider).to be_an_instance_of Puppet::Type.type(:lxca_discover_request).provider(:lxca_discover_request)
    end

    it "with job_id should be an instance of provider ruby" do
      expect(discover_request_with_job_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_discover_request).provider(:lxca_discover_request)
    end
  end

  describe "for ensurable discover_manageable_devices" do
    it "should have ip_addresses as a parameter" do
      expect {discover_request.provider.discover_manageable_devices}.to raise_error(Puppet::Error, /Attribute ip_addresses is mandatory for the ensurable discover_manageable_devices/)
    end
  end

  describe "for ensurable discover_manageable_devices" do
    it "response should have location" do
      expect(discover_request_with_ip_addr.provider.discover_manageable_devices.headers).to include "location" 
    end
  end

  describe "for ensurable monitor_discover_request" do
    it "should have job_id as a parameter" do
      expect {discover_request.provider.monitor_discover_request}.to raise_error(Puppet::Error, /Attribute job_id is mandatory for the ensurable monitor_discover_request/)
    end
  end

  describe "for ensurable monitor_discover_request" do
    it "should return an array as a result" do
      expect(discover_request_with_job_id.provider.monitor_discover_request).to be_instance_of(Array)
    end
  end

end
