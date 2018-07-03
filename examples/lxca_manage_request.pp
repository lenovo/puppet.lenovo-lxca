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

# This manifest contains some sample invocations of lxca_manage_request resource type

lxca_manage_request{'fetch_manage_request':
  ensure         => 'fetch_manage_request',
  job_id         => '4191',
}

lxca_manage_request{'manage_discovered_devices':
  ensure            => 'manage_discovered_devices',
  ip_address        => ['10.243.8.28'],
  username          => 'USERID',
  password          => 'CME44ibm',
  recovery_password => 'CME55ibm',
  force             => 'True'
}

