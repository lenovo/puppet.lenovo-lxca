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

describe Puppet::Type.type(:lxca_switches) do

  before do
    @switches_example = {
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
    }
   
    @provider = stub('provider', :class => described_class.defaultprovider, :clear => nil)
    described_class.defaultprovider.stubs(:new).returns(@provider)
  end

  it "should have :name be its namevar" do
    described_class.key_attributes.should == [:name]
  end

  describe "when validating attributes" do
    [:name, :provider, :host, :port, :login_user, :login_password, :verify_ssl].each do |param|
      it "should have a #{param} parameter" do
        described_class.attrtype(param).should == :param
      end
    end
  
    [:ensure].each do |prop|
      it "should have a #{prop} property" do
        described_class.attrtype(prop).should == :property
      end
    end
  end

  describe "for ensure" do
    it "should not support other values" do
      expect { described_class.new(:name => 'lxca_switches', :ensure => 'foo') }.to raise_error(Puppet::Error, /Invalid value "foo"/)
    end

    it "should not have a default value" do
      described_class.new(:name => 'lxca_switches')[:ensure].should == nil
    end
    
  end

  describe "for host" do
    it "should not have a default value" do
      described_class.new(:name => 'lxca_switches')[:host].should == nil
    end
  end

  describe "for port" do
    it "should not have a default value" do
      described_class.new(:name => 'lxca_switches')[:port].should == nil
    end
  end

  describe "for login_user" do
    it "should not have a default value" do
        described_class.new(:name => 'lxca_switches')[:login_user].should == nil
    end
  end

  describe "for login_password" do
    it "should not have a default value" do
        described_class.new(:name => 'lxca_switches')[:login_password].should == nil
    end
  end

  describe "for verify_ssl" do
    it "should not have a default value" do
      described_class.new(:name => 'lxca_switches')[:verify_ssl].should == nil
    end
  end

  describe "for auth_type" do
    it "should have a default value of 'basic_auth" do
      described_class.new(:name => 'lxca_switches', :ensure => 'discover_all')[:auth_type].should == 'basic_auth'
    end
  end

end 
