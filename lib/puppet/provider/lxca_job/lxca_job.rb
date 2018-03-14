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

Puppet::Type.type(:lxca_job).provide(:lxca_job) do
  desc 'Job provider for LXCA resource'
  
  def create_client
    conf=XClarityClient::Configuration.new(
      :username => @resource['login_user'],
      :password => @resource['login_password'],
      :host => @resource['host'],
      :port => @resource['port'],
      :auth_type => @resource['auth_type'],
      :verify_ssl => @resource['verify_ssl']
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
    @client.discover_jobs.map do |job|
      job.instance_variables.each do |att|
        puts "#{att} - #{job.instance_variable_get att}"
      end
    end
  end

  def filter_by_id
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _("Attribute id is mandatory for the ensurable filter_by_id")
    end
    @client.fetch_jobs(["#{@resource[:id]}"]).map do |job|
      job.instance_variables.each do |att|
        puts "#{att} - #{job.instance_variable_get att}"
      end
    end
  end

  def filter_by_uuid
    create_client if @client.nil?
    if @resource[:uuid].nil?
      raise Puppet::Error, _("Attribute uuid is mandatory for the ensurable filter_by_uuid")
    end

    @client.discover_jobs({:uuid => "#{@resource[:uuid]}"}).map do |job|
      job.instance_variables.each do |att|
        puts "#{att} - #{job.instance_variable_get att}"
      end
    end
  end

  def filter_by_state
    create_client if @client.nil?
    if @resource[:state].nil?
      raise Puppet::Error, _("Attribute state is mandatory for the ensurable filter_by_state")
    end

    @client.discover_jobs({:state => "#{@resource[:state]}"}).map do |job|
      job.instance_variables.each do |att|
        puts "#{att} - #{job.instance_variable_get att}"
      end
    end
  end

  def cancel_job
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _("Attribute id is mandatory when ensure is set to cancel_job")
    end
    @client.cancel_job(@resource[:id])
  end

  def delete_job
    create_client if @client.nil?
    if @resource[:id].nil?
      raise Puppet::Error, _("Attribute id is mandatory when ensure is set to delete_job")
    end
    @client.delete_job(@resource[:id])
  end

end

