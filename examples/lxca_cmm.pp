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

# This manifest contains some sample invocations of lxca_cmm resource type

lxca_cmm{'list_all':
  ensure         => 'discover_all',
}

lxca_cmm{'filter_by_chassis':
  ensure         => 'filter_by_chassis',
  chassis        => 'F44E92339683385A8D97CD6348A6F45F',
}

lxca_cmm{'filter_by_uuid':
  ensure         => 'filter_by_uuid',
  uuid           => 'FA59C0BBC43C3C15B9D72B94AFF52B91',
}

