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

describe Puppet::Type.type(:lxca_config_pattern).provider(:lxca_config_pattern) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_config_pattern).stubs(:defaultprovider).returns described_class
  end

  let :config_pattern do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
    )
  end
  
  let :config_pattern_with_id do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '59'
    )
  end

  let :config_pattern_deploy do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '59',
      :endpoints => 'B918EDCA1B5F11E2803EBECB82710ADE',
      :restart => 'pending',
      :etype => 'node'
    )
  end

  let :config_pattern_deploy1 do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '59',
      :restart => 'pending',
      :etype => 'node'
    )
  end

  let :config_pattern_deploy2 do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '59',
      :endpoints => 'B918EDCA1B5F11E2803EBECB82710ADE',
      :etype => 'node'
    )
  end

  let :config_pattern_deploy3 do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '59',
      :endpoints => 'B918EDCA1B5F11E2803EBECB82710ADE',
      :restart => 'pending'
    )
  end

  let :config_pattern_import do
    Puppet::Type.type(:lxca_config_pattern).new(
      :name => 'lxca_config_pattern',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :import_json => '{"template_type" : "SystemInfo","template" : {"contact" : "contact","description" : "Pattern created by ruby test API ","location" : "location","name" : "Learned-System_Info-99","systemName" : {"autogen" : "Disable","hyphenChecked" : "FALSE"},"type" : "SystemInfo","uri" : "\/config\/template\/62","userDefined" : "TRUE"}}'
    )
  end

  describe "provider instance type" do
    it "without id, endpoints, restart, etype and import_json should be an instance of provider ruby" do
      expect(config_pattern.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_pattern).provider(:lxca_config_pattern)
    end
    it "with id should be an instance of provider ruby" do
      expect(config_pattern_with_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_pattern).provider(:lxca_config_pattern)
    end
    it "with id, endpoints, restart, etype should be an instance of provider ruby" do
      expect(config_pattern_deploy.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_pattern).provider(:lxca_config_pattern)
    end
    it "with import_json should be an instance of provider ruby" do
      expect(config_pattern_import.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_pattern).provider(:lxca_config_pattern)
    end
  end

  describe "for ensurable filter_by_id" do
    it "should have id as a parameter" do
      expect {config_pattern.provider.filter_by_id}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable filter_by_id/)
    end
  end

  describe "for ensurable export_config_pattern" do
    it "should have id as a parameter" do
      expect {config_pattern.provider.export_config_pattern}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable export_config_pattern/)
    end
  end

  describe "for ensurable deploy_config_pattern" do
    it "should have id as a parameter" do
      expect {config_pattern.provider.deploy_config_pattern}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable deploy_config_pattern/)
    end
  end

  describe "for ensurable deploy_config_pattern" do
    it "should have endpoints as a parameter" do
      expect {config_pattern_deploy1.provider.deploy_config_pattern}.to raise_error(Puppet::Error, /Attribute endpoints is mandatory for the ensurable deploy_config_pattern/)
    end
  end

  describe "for ensurable deploy_config_pattern" do
    it "should have restart as a parameter" do
      expect {config_pattern_deploy2.provider.deploy_config_pattern}.to raise_error(Puppet::Error, /Attribute restart is mandatory for the ensurable deploy_config_pattern/)
    end
  end

  describe "for ensurable deploy_config_pattern" do
    it "should have etype as a parameter" do
      expect {config_pattern_deploy3.provider.deploy_config_pattern}.to raise_error(Puppet::Error, /Attribute etype is mandatory for the ensurable deploy_config_pattern/)
    end
  end

  describe "for ensurable import_config_pattern" do
    it "should have import_json as a parameter" do
      expect {config_pattern.provider.import_config_pattern}.to raise_error(Puppet::Error, /Attribute import_json is mandatory for the ensurable import_config_pattern/)
    end
  end

  describe "for discover_all" do
    it "should return an array as a result" do
      expect(config_pattern.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe "for filter_by_id" do
    it "should return an array as a result" do
      expect(config_pattern_with_id.provider.filter_by_id).to be_instance_of(Array)
    end
  end

  describe "for export_config_pattern" do
    it "should return an array as a result" do
      expect(config_pattern_with_id.provider.export_config_pattern).to be_instance_of(Array)
    end
  end

  describe "for deploy_config_pattern" do
    it "should return an array as a result" do
      expect(config_pattern_deploy.provider.deploy_config_pattern.status).to eq(200)
    end
  end

  describe "for import_config_pattern" do
    it "should return status as 200" do
      expect(config_pattern_import.provider.import_config_pattern.status).to eq(200)
    end
  end

end
