################################################################################
# <LENOVO COPYRIGHT TO BE INSERTED>
#
# <The below Apache License information to be reviewed by legal
# and modified if need be>
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

describe Puppet::Type.type(:lxca_manage_request).provider(:lxca_manage_request) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_manage_request).stubs(:defaultprovider).returns described_class
  end

  let :manage_request do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
    )
  end

  let :manage_request_with_ip_addr do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_address => ['10.243.8.28'],
      :username => 'USERID',
      :password => 'CME44ibm',
      :recovery_password => 'CME55ibm',
      :force => 'True',
    )
  end

  let :manage_request_without_username do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_address => ['10.243.8.28'],
      :password => 'CME44ibm',
      :recovery_password => 'CME55ibm',
      :force => 'True',
    )
  end

  let :manage_request_without_password do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_address => ['10.243.8.28'],
      :username => 'USERID',
      :recovery_password => 'CME55ibm',
      :force => 'True',
    )
  end

  let :manage_request_without_rec_pass do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_address => ['10.243.8.28'],
      :username => 'USERID',
      :password => 'CME44ibm',
      :force => 'True',
    )
  end

  let :manage_request_without_force do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :ip_address => ['10.243.8.28'],
      :username => 'USERID',
      :password => 'CME44ibm',
      :recovery_password => 'CME55ibm',
    )
  end

  let :manage_request_with_job_id do
    Puppet::Type.type(:lxca_manage_request).new(
      :name => 'lxca_manage_request',
      :host => 'https://10.243.13.140',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :job_id => '3124',
    )
  end

  describe "provider instance type" do
    it "with ip_addresses should be an instance of provider ruby" do
      expect(manage_request_with_ip_addr.provider).to be_an_instance_of Puppet::Type.type(:lxca_manage_request).provider(:lxca_manage_request)
    end

    it "with job_id should be an instance of provider ruby" do
      expect(manage_request_with_job_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_manage_request).provider(:lxca_manage_request)
    end
  end

  describe "for ensurable manage_discovered_devices" do
    it "should have ip_address as a parameter" do
      expect {manage_request.provider.manage_discovered_devices}.to raise_error(Puppet::Error, /Attribute ip_address is mandatory for the ensurable manage_discovered_devices/)
    end

    it "should have username as a parameter" do
      expect {manage_request_without_username.provider.manage_discovered_devices}.to raise_error(Puppet::Error, /Attribute username is mandatory for the ensurable manage_discovered_devices/)
    end

    it "should have password as a parameter" do
      expect {manage_request_without_password.provider.manage_discovered_devices}.to raise_error(Puppet::Error, /Attribute password is mandatory for the ensurable manage_discovered_devices/)
    end

    it "should have recovery_password as a parameter" do
      expect {manage_request_without_rec_pass.provider.manage_discovered_devices}.to raise_error(Puppet::Error, /Attribute recovery_password is mandatory for the ensurable manage_discovered_devices/)
    end

    it "should have force as a parameter" do
      expect {manage_request_without_force.provider.manage_discovered_devices}.to raise_error(Puppet::Error, /Attribute force is mandatory for the ensurable manage_discovered_devices/)
    end
  end

  describe "for ensurable manage_discovered_devices" do
    it "should ensure the request to have been made" do
      job_id = manage_request_with_ip_addr.provider.manage_discovered_devices.status
      puts "Printing now"
      puts job_id
      puts "printing end"
    end
  end

  describe "for ensurable fetch_manage_request" do
    it "should have job_id as a parameter" do
      expect {manage_request.provider.fetch_manage_request}.to raise_error(Puppet::Error, /Attribute job_id is mandatory for the ensurable fetch_manage_request/)
    end
  end

  describe "for ensurable fetch_manage_request" do
    it "should return an array as a result" do
      expect(manage_request_with_job_id.provider.fetch_manage_request).to be_instance_of(Array)
    end
  end

end
