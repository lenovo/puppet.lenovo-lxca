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

Puppet::Type.newtype(:lxca_job) do

  ensurable do
    
    newvalue(:discover_all) do
      Puppet.notice "Fetching all the LXCA job elements. Results displayed below\n"
      provider.discover_all
    end

    newvalue(:filter_by_id) do
      Puppet.notice "Fetching all the LXCA job elements filtered by id of the job. Results displayed below\n"
      provider.filter_by_id
    end
    
    newvalue(:filter_by_uuid) do
      Puppet.notice "Fetching LXCA job filtered by UUID of the device. Results displayed below\n"
      provider.filter_by_uuid
    end
   
    newvalue(:filter_by_state) do
      Puppet.notice "Fetching LXCA job filtered by state of the job. Results displayed below\n"
      provider.filter_by_state
    end
 
    newvalue(:cancel_job) do
      Puppet.notice "Cancelling the job"
      provider.cancel_job
    end

    newvalue(:delete_job) do
      Puppet.notice "Deleting the job"
      provider.delete_job
    end

  end
                                  
  newparam(:name, :namevar => true) do
    desc "Name for the lxca job resource"
  end
                                              
  newparam(:host) do
    desc "LXCA Host to connect to"
  end

  newparam(:port) do
    desc "Port of LXCA to connect to"
  end

  newparam(:login_user) do
    desc "The username to be used to login into LXCA"
  end

  newparam(:login_password) do
    desc "The password to be used to login into LXCA"
  end

  newparam(:verify_ssl) do
    desc "Whether to verify SSL when connecting to the LXCA"
  end

  newparam(:auth_type) do
    desc "The authorization type used to connect to LXCA. Defaults to basic_auth"
    defaultto 'basic_auth'
  end

  newparam(:csrf_token) do
    desc "The CSRF token to be used in case authentication type is set to token"
  end

  newparam(:uuid) do
    desc "UUID of the device associated with which the jobs are to be fetched"
  end

  newparam(:id) do
    desc "ID of the job on which filtering is to be applied"
  end
 
  newparam(:state) do
    desc "State of the job based on which the list of jobs is to be filtered"
  end

  validate do
    required_parameters = [
      :host,
      :port,
      :login_user,
      :login_password,
      :verify_ssl,
    ]
    required_parameters.each do |param|
      if param.nil? or param == ""
        raise Puppet::Error, _("Attribute #{param} is mandatory and should not be empty")
      end
    end
  end    

end

