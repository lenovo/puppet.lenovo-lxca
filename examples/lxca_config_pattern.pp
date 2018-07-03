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

# This manifest contains some sample invocations of lxca_config_pattern resource type

lxca_config_pattern{'list_all':
  ensure         => 'discover_all',
}

lxca_config_pattern{'filter_by_patternid':
  ensure         => 'filter_by_id',
  id             => '59',
}

lxca_config_pattern{'export_config_pattern':
  ensure         => 'export_config_pattern',
  id             => '59',
}

lxca_config_pattern{'deploy_config_pattern':
  ensure         => 'deploy_config_pattern',
  id             => '59',
  endpoints      => 'B918EDCA1B5F11E2803EBECB82710ADE',
  restart        => 'pending',
  etype          => 'node',
}

lxca_config_pattern{'import_config_pattern':
  ensure         => 'import_config_pattern',
  import_json    => '{"template_type" : "SystemInfo","template" : {"contact" : "contact","description" : "Pattern created by ruby test API ","location" : "location","name" : "Learned-System_Info-99","systemName" : {"autogen" : "Disable","hyphenChecked" : "FALSE"},"type" : "SystemInfo","uri" : "\/config\/template\/62","userDefined" : "TRUE"}}',
}


