################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2018.
#
# LIMITED AND RESTRICTED RIGHTS NOTICE:
# If data or software is delivered pursuant a General Services
# Administration (GSA) contract, use, reproduction, or disclosure
# is subject to restrictions set forth in Contract No. GS-35F-05925.
#-------------------------------------------------------------
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
  ensure => 'discover_all',
}

lxca_node{'list_managed':
  ensure => 'discover_managed',
}

lxca_node{'list_unmanaged':
  ensure => 'discover_unmanaged',
}

lxca_node{'filter_by_chassis':
  ensure  => 'filter_by_chassis',
  chassis => 'F44E92339683385A8D97CD6348A6F45F',
}

lxca_node{'filter_by_uuid':
  ensure => 'filter_by_uuid',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_on':
  ensure => 'power_on',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_off':
  ensure => 'power_off',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'power_restart':
  ensure => 'power_restart',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'blink_led':
  ensure => 'blink_led',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'turn_on_led':
  ensure => 'turn_on_led',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

lxca_node{'turn_off_led':
  ensure => 'turn_off_led',
  uuid   => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}
