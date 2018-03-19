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

describe Puppet::Type.type(:lxca_job).provider(:lxca_job) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_job).stubs(:defaultprovider).returns described_class
  end

  let :job do
    Puppet::Type.type(:lxca_job).new(
      :name => 'lxca_job',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
    )
  end
  
  let :job_with_deviceid do
    Puppet::Type.type(:lxca_job).new(
      :name => 'lxca_job',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :uuid => 'F44E92339683385A8D97CD6348A6F45F'
    )
  end

  let :job_with_jobid do
    Puppet::Type.type(:lxca_job).new(
      :name => 'lxca_job',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :id => '6'
    )
  end

  let :job_with_state do
    Puppet::Type.type(:lxca_job).new(
      :name => 'lxca_job',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :state => 'Complete'
    )
  end

  describe "provider instance type" do
    it "without uuid, id and state should be an instance of provider ruby" do
      expect(job.provider).to be_an_instance_of Puppet::Type.type(:lxca_job).provider(:lxca_job)
    end
    it "with id should be an instance of provider ruby" do
      expect(job_with_jobid.provider).to be_an_instance_of Puppet::Type.type(:lxca_job).provider(:lxca_job)
    end
    it "with uuid should be an instance of provider ruby" do
      expect(job_with_deviceid.provider).to be_an_instance_of Puppet::Type.type(:lxca_job).provider(:lxca_job)
    end
    it "with state should be an instance of provider ruby" do
      expect(job_with_state.provider).to be_an_instance_of Puppet::Type.type(:lxca_job).provider(:lxca_job)
    end
  end

  describe "for ensurable filter_by_id" do
    it "should have id as a parameter" do
      expect {job.provider.filter_by_id}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable filter_by_id/)
    end
  end

  describe "for ensurable filter_by_uuid" do
    it "should have uuid as a parameter" do
      expect {job.provider.filter_by_uuid}.to raise_error(Puppet::Error, /Attribute uuid is mandatory for the ensurable filter_by_uuid/)
    end
  end

  describe "for ensurable filter_by_state" do
    it "should have state as a parameter" do
      expect {job.provider.filter_by_state}.to raise_error(Puppet::Error, /Attribute state is mandatory for the ensurable filter_by_state/)
    end
  end

  describe "for ensurable cancel_job" do
    it "should have id as a parameter" do
      expect {job.provider.cancel_job}.to raise_error(Puppet::Error, /Attribute id is mandatory when ensure is set to cancel_job/)
    end
  end

  describe "for ensurable delete_job" do
    it "should have id as a parameter" do
      expect {job.provider.delete_job}.to raise_error(Puppet::Error, /Attribute id is mandatory when ensure is set to delete_job/)
    end
  end

  describe "for discover_all" do
    it "should return an array as a result" do
      expect(job.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe "for filter_by_deviceid" do
    it "should return an array as a result" do
      expect(job_with_deviceid.provider.filter_by_uuid).to be_instance_of(Array)
    end
  end

  describe "for filter_by_jobid" do
    it "should return an array as a result" do
      expect(job_with_jobid.provider.filter_by_id).to be_instance_of(Array)
    end
  end

  describe "for filter_by_state" do
    it "should return an array as a result" do
      expect(job_with_state.provider.filter_by_state).to be_instance_of(Array)
    end
  end

  describe "for cancel_job" do
    it "should return status as 200" do
      expect(job_with_jobid.provider.cancel_job.status).to eq(200)
    end
  end

  describe "for delete_job" do
    it "should return status as 200" do
      expect(job_with_jobid.provider.delete_job.status).to eq(200)
    end
  end

end
