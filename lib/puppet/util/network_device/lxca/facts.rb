################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2016.
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

# This class fetch facts like lxca version from LXCA
class Puppet::Util::NetworkDevice::Lxca::Facts
  # facts class for lxca
  attr_reader :transport

  def initialize(transport)
    Puppet.debug(self.class.to_s.split('::').last + ': Inside Initialize of Facts!')
    @transport = transport
  end

  def retrieve
    Puppet.debug(self.class.to_s.split('::').last + ': Retrieving Facts from facts.rb!')
    facts = {}
    facts.merge(parse_device_facts)
  end

  def parse_device_facts
    facts = {
    }
    if response = @transport.call('')
      Puppet.debug("response  = #{response}")
      result = response
    else
      Puppet.warning('Did not receive device details. Lxca REST requires Administrator level access.')
      return facts
    end
    facts['lxca_name'] = result[0].appliance['name'].to_s
    facts['version'] = result[0].appliance['version'].to_s
    puts facts

    facts.each do |key, value|
      Puppet.notice("Key  = #{key} , Value = #{value}")
    end

    facts
  end
end
