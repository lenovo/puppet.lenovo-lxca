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

# This manifest contains some sample invocations of lxca_node resource type

lxca_node{'list_all':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'discover_all',
}

lxca_node{'list_managed':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'discover_managed',
}

lxca_node{'list_unmanaged':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'discover_unmanaged',
}

lxca_node{'filter_by_chassis':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'filter_by_chassis',
  chassis => 'F44E92339683385A8D97CD6348A6F45F',
}

lxca_node{'filter_by_uuid':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'filter_by_uuid',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_on':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'power_on',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_off':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'power_off',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_restart':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'power_restart',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'blink_led':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'blink_led',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'turn_on_led':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'turn_on_led',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'turn_off_led':
  host => 'https://10.243.10.75',
  port => '443',
  login_user => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl => 'NONE',
  ensure => 'turn_off_led',
  uuid => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}
