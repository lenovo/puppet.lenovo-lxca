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

# This manifest contains some sample invocations of lxca_config_profile resource type

lxca_config_profile{'list_all':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'discover_all',
}

lxca_config_profile{'filter_by_profileid':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'filter_by_id',
  id => '68',
}

lxca_config_profile{'activate_config_profile':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'activate_config_profile',
  id => '68',
  endpoint_uuid => '46920C143355486F97C19A34ABC7D746_bay10',
  restart => 'immediate',
}

lxca_config_profile{'rename_config_profile':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'rename_config_profile',
  id => '68',
  profile_name => 'name_from_puppet_type',
}

lxca_config_profile{'unassign_config_profile':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'unassign_config_profile',
  id => '68',
  power_down => 'False',
  reset_imm => 'False',
  force => 'False',
}

lxca_config_profile{'delete_config_profile':
  host => 'https://10.240.29.217',
  port => '443',
  login_user => 'USERID',
  login_password => 'Passw0rd',
  verify_ssl => 'NONE',
  ensure => 'delete_config_profile',
  id => '68',
}
