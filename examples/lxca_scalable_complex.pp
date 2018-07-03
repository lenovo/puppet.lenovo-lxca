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

# This manifest contains some sample invocations of lxca_scalable_complex resource type

lxca_scalable_complex{'list_all':
  ensure         => 'discover_all',
}

lxca_scalable_complex{'list_managed':
  ensure         => 'discover_managed',
}

lxca_scalable_complex{'list_unmanaged':
  ensure         => 'discover_unmanaged',
}

lxca_scalable_complex{'list_flex':
  ensure         => 'discover_flex',
}

lxca_scalable_complex{'list_rackserver':
  ensure         => 'discover_rackserver',
}

lxca_scalable_complex{'filter_by_uuid':
  ensure         => 'filter_by_uuid',
  port           => '443',
  login_user     => 'Admin',
  login_password => 'Lenovo123',
  verify_ssl     => 'NONE',
  host           => 'https://10.243.10.75',
  uuid           => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

