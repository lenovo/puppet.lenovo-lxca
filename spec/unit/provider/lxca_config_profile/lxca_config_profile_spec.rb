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

describe Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_config_profile).stubs(:defaultprovider).returns described_class
  end

  let :config_profile do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
    )
  end
  
  let :config_profile_with_id do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68'
    )
  end

  let :config_profile_rename do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :profile_name => 'New name from type'
    )
  end

  let :config_profile_activate do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :endpoint_uuid => '46920C143355486F97C19A34ABC7D746_bay10',
      :restart => 'immediate'
    )
  end

  let :config_profile_activate1 do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :endpoint_uuid => '46920C143355486F97C19A34ABC7D746_bay10',
    )
  end

  let :config_profile_unassign do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :power_down => 'False',
      :reset_imm => 'False',
      :force => 'False'
    )
  end

  let :config_profile_unassign1 do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :reset_imm => 'False',
      :force => 'False'
    )
  end

  let :config_profile_unassign2 do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :power_down => 'False',
      :force => 'False'
    )
  end

  let :config_profile_unassign3 do
    Puppet::Type.type(:lxca_config_profile).new(
      :name => 'lxca_config_profile',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
      :id => '68',
      :power_down => 'False',
      :reset_imm => 'False'
    )
  end


  describe "provider instance type" do
    it "without id, profile_name, endpoint_uuid, restart, power_down, reset_imm and force should be an instance of provider ruby" do
      expect(config_profile.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile)
    end
    it "with id should be an instance of provider ruby" do
      expect(config_profile_with_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile)
    end
    it "with id and profile_name should be an instance of provider ruby" do
      expect(config_profile_rename.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile)
    end
    it "with id, endpoint_uuid and restart should be an instance of provider ruby" do
      expect(config_profile_activate.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile)
    end
    it "with id, power_down, reset_imm and force should be an instance of provider ruby" do
      expect(config_profile_unassign.provider).to be_an_instance_of Puppet::Type.type(:lxca_config_profile).provider(:lxca_config_profile)
    end
  end

  describe "for ensurable filter_by_id" do
    it "should have id as a parameter" do
      expect {config_profile.provider.filter_by_id}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable filter_by_id/)
    end
  end

  describe "for ensurable delete_config_profile" do
    it "should have id as a parameter" do
      expect {config_profile.provider.delete_config_profile}.to raise_error(Puppet::Error, /Attribute id is mandatory when ensure is set to delete_config_profile/)
    end
  end

  describe "for ensurable rename_config_profile" do
    it "should have id as a parameter" do
      expect {config_profile.provider.rename_config_profile}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable rename_config_profile/)
    end
  end

  describe "for ensurable rename_config_profile" do
    it "should have profile_name as a parameter" do
      expect {config_profile_with_id.provider.rename_config_profile}.to raise_error(Puppet::Error, /Attribute profile_name is mandatory for the ensurable rename_config_profile/)
    end
  end

  describe "for ensurable activate_config_profile" do
    it "should have id as a parameter" do
      expect {config_profile.provider.activate_config_profile}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable activate_config_profile/)
    end
  end

  describe "for ensurable activate_config_profile" do
    it "should have endpoint_uuid as a parameter" do
      expect {config_profile_with_id.provider.activate_config_profile}.to raise_error(Puppet::Error, /Attribute endpoint_uuid is mandatory for the ensurable activate_config_profile/)
    end
  end

  describe "for ensurable activate_config_profile" do
    it "should have restart as a parameter" do
      expect {config_profile_activate1.provider.activate_config_profile}.to raise_error(Puppet::Error, /Attribute restart is mandatory for the ensurable activate_config_profile/)
    end
  end

  describe "for ensurable unassign_config_profile" do
    it "should have id as a parameter" do
      expect {config_profile.provider.unassign_config_profile}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable unassign_config_profile/)
    end
  end

  describe "for ensurable unassign_config_profile" do
    it "should have power_down as a parameter" do
      expect {config_profile_unassign1.provider.unassign_config_profile}.to raise_error(Puppet::Error, /Attribute power_down is mandatory for the ensurable unassign_config_profile/)
    end
  end

  describe "for ensurable unassign_config_profile" do
    it "should have reset_imm as a parameter" do
      expect {config_profile_unassign2.provider.unassign_config_profile}.to raise_error(Puppet::Error, /Attribute reset_imm is mandatory for the ensurable unassign_config_profile/)
    end
  end

  describe "for ensurable unassign_config_profile" do
    it "should have force as a parameter" do
      expect {config_profile_unassign3.provider.unassign_config_profile}.to raise_error(Puppet::Error, /Attribute force is mandatory for the ensurable unassign_config_profile/)
    end
  end

  describe "for discover_all" do
    it "should return an array as a result" do
      expect(config_profile.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe "for filter_by_id" do
    it "should return an array as a result" do
      expect(config_profile_with_id.provider.filter_by_id).to be_instance_of(Array)
    end
  end

  describe "for activate_config_profile" do
    it "should return an array as a result" do
      expect(config_profile_activate.provider.activate_config_profile.status).to eq(200)
    end
  end

  describe "for unassign_config_profile" do
    it "should return status as 200" do
      expect(config_profile_unassign.provider.unassign_config_profile.status).to eq(200)
    end
  end

  describe "for rename_config_profile" do
    it "should return status as 204" do
      expect(config_profile_rename.provider.rename_config_profile.status).to eq(204)
    end
  end

  describe "for delete_config_profile" do
    it "should return status as 200" do
      expect(config_profile_with_id.provider.delete_config_profile.status).to eq(200)
    end
  end

end
