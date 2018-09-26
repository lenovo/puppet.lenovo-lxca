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

require 'puppet/util/network_device/base'
require File.join(File.dirname(__FILE__), '../lxca')
require File.join(File.dirname(__FILE__), '../lxca/facts')
require File.join(File.dirname(__FILE__), '../transport/lxca')

require 'uri'

# this wraps lxca as device
class Puppet::Util::NetworkDevice::Lxca::Device
  attr_reader :connection
  attr_accessor :url, :transport

  def initialize(url, options = {})
    @url = URI.parse(url)

    @autoloader = Puppet::Util::Autoload.new(
      self,
      'puppet/util/network_device/transport',
    )
    if @autoloader.load('lxca')
      @transport = Puppet::Util::NetworkDevice::Transport::Lxca.new(url, options[:debug])
      Puppet.debug(self.class.to_s.split('::').last + ': Inside Device Initialize')
    end
  end

  def facts
    Puppet.debug(self.class.to_s.split('::').last + ': Inside Device FACTS Initialize')
    @facts ||= Puppet::Util::NetworkDevice::Lxca::Facts.new(@transport)

    @facts.retrieve
  end
end
