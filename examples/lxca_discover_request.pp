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

# This manifest contains some sample invocations of lxca_discover_request resource type

lxca_discover_request{'discover_manageable_devices':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'discover_manageable_devices',
  ip_addresses => ['10.240.74.210']
}

lxca_discover_request{'monitor_discover_request':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'monitor_discover_request',
  job_id => '5878'
}

