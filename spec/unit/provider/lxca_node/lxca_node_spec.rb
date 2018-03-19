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

describe Puppet::Type.type(:lxca_node).provider(:lxca_node) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_node).stubs(:defaultprovider).returns described_class
  end

  let :node do
    Puppet::Type.type(:lxca_node).new(
      :name => 'lxca_node',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
    )
  end
  
  let :node_with_chassis do
    Puppet::Type.type(:lxca_node).new(
      :name => 'lxca_node',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :chassis => 'F44E92339683385A8D97CD6348A6F45F'
    )
  end

  let :node_with_uuid do
    Puppet::Type.type(:lxca_node).new(
      :name => 'lxca_node',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91'
    )
  end

  describe "provider instance type" do
    it "without uuid and chassis should be an instance of provider ruby" do
      expect(node.provider).to be_an_instance_of Puppet::Type.type(:lxca_node).provider(:lxca_node)
    end
    it "with chassis should be an instance of provider ruby" do
      expect(node_with_chassis.provider).to be_an_instance_of Puppet::Type.type(:lxca_node).provider(:lxca_node)
    end
    it "with uuid should be an instance of provider ruby" do
      expect(node_with_uuid.provider).to be_an_instance_of Puppet::Type.type(:lxca_node).provider(:lxca_node)
    end
  end

  describe "for ensurable filter_by_chassis" do
    it "should have chassis as a parameter" do
      expect {node.provider.filter_by_chassis}.to raise_error(Puppet::Error, /Attribute chassis is mandatory for the ensurable filter_by_chassis/)
    end
  end

  describe "for ensurable filter_by_uuid" do
    it "should have uuid as a parameter" do
      expect {node.provider.filter_by_uuid}.to raise_error(Puppet::Error, /Attribute uuid is mandatory for the ensurable filter_by_uuid/)
    end
  end

  describe "for ensurable power_on" do
    it "should have uuid as a parameter" do
      expect {node.provider.power_on}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to power_on/)
    end
  end

  describe "for ensurable power_off" do
    it "should have uuid as a parameter" do
      expect {node.provider.power_off}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to power_off/)
    end
  end

  describe "for ensurable power_restart" do
    it "should have uuid as a parameter" do
      expect {node.provider.power_restart}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to power_restart/)
    end
  end

  describe "for ensurable blink_led" do
    it "should have uuid as a parameter" do
      expect {node.provider.blink_led}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to blink_led/)
    end
  end

  describe "for ensurable turn_on_led" do
    it "should have uuid as a parameter" do
      expect {node.provider.turn_on_led}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to turn_on_led/)
    end
  end

  describe "for ensurable turn_off_led" do
    it "should have uuid as a parameter" do
      expect {node.provider.turn_off_led}.to raise_error(Puppet::Error, /Attribute uuid is mandatory when ensure is set to turn_off_led/)
    end
  end

  describe "for discover_all" do
    it "should return an array as a result" do
      expect(node.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe "for discover_managed" do
    it "should return an array as a result" do
      expect(node.provider.discover_managed_nodes).to be_instance_of(Array)
    end
  end

  describe "for discover_unmanaged" do
    it "should return an array as a result" do
      expect(node.provider.discover_unmanaged_nodes).to be_instance_of(Array)
    end
  end

  describe "for filter_by_chassis" do
    it "should return an array as a result" do
      expect(node_with_chassis.provider.filter_by_chassis).to be_instance_of(Array)
    end
  end

  describe "for filter_by_uuid" do
    it "should return an array as a result" do
      expect(node_with_uuid.provider.filter_by_uuid).to be_instance_of(Array)
    end
  end

  describe "for power_on" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.power_on.status).to eq(200)
    end
  end

  describe "for power_off" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.power_off.status).to eq(200)
    end
  end

  describe "for power_restart" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.power_restart.status).to eq(200)
    end
  end

  describe "for blink_led" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.blink_led.status).to eq(200)
    end
  end

  describe "for turn_on_led" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.turn_on_led.status).to eq(200)
    end
  end

  describe "for turn_off_led" do
    it "should return status as 200" do
      expect(node_with_uuid.provider.turn_off_led.status).to eq(200)
    end
  end

end
