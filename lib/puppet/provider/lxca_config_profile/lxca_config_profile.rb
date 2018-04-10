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

require 'xclarity_client'

Puppet::Type.type(:lxca_config_profile).provide(:lxca_config_profile) do
  desc 'Configuration profile provider for LXCA resource'

  def create_client
    conf = XClarityClient::Configuration.new(
      username: @resource['login_user'],
      password: @resource['login_password'],
      host: @resource['host'],
      port: @resource['port'],
      auth_type: @resource['auth_type'],
      verify_ssl: @resource['verify_ssl'],
    )
    @client = XClarityClient::Client.new(conf)
  end

  def exists?
    return if @client.nil?
  end

  def create
    create_client
  end

  def destroy
    @client = nil
  end

  def discover_all
    create_client if @client.nil?
    @client.discover_config_profile.map do |profile|
      profile.instance_variables.each do |att|
        puts "#{att} - #{profile.instance_variable_get att}"
      end
    end
  end

  def filter_by_id
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable filter_by_id')
    end
    @client.fetch_config_profile([(@resource[:id]).to_s]).map do |profile|
      profile.instance_variables.each do |att|
        puts "#{att} - #{profile.instance_variable_get att}"
      end
    end
  end

  def rename_config_profile
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable rename_config_profile')
    end
    if @resource[:profile_name].nil?
      raise Puppet::Error, _('Attribute profile_name is mandatory for the ensurable rename_config_profile')
    end

    @client.rename_config_profile((@resource[:id]).to_s, (@resource[:profile_name]).to_s)
  end

  def activate_config_profile
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable activate_config_profile')
    end
    if @resource[:endpoint_uuid].nil?
      raise Puppet::Error, _('Attribute endpoint_uuid is mandatory for the ensurable activate_config_profile')
    end
    if @resource[:restart].nil?
      raise Puppet::Error, _('Attribute restart is mandatory for the ensurable activate_config_profile')
    end

    @client.activate_config_profile((@resource[:id]).to_s, (@resource[:endpoint_uuid]).to_s, (@resource[:restart]).to_s)
  end

  def unassign_config_profile
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:power_down].nil?
      raise Puppet::Error, _('Attribute power_down is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:reset_imm].nil?
      raise Puppet::Error, _('Attribute reset_imm is mandatory for the ensurable unassign_config_profile')
    end
    if @resource[:force].nil?
      raise Puppet::Error, _('Attribute force is mandatory for the ensurable unassign_config_profile')
    end

    @client.unassign_config_profile((@resource[:id]).to_s, (@resource[:power_down]).to_s, (@resource[:reset_imm]).to_s, (@resource[:force]).to_s)
  end

  def delete_config_profile
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _('Attribute id is mandatory when ensure is set to delete_config_profile')
    end
    @client.delete_config_profile(@resource[:id])
  end
end
