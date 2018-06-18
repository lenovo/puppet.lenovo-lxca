require 'puppet/util/network_device/base'
require File.join(File.dirname(__FILE__), '../lxca')
require File.join(File.dirname(__FILE__), '../lxca/facts')
require File.join(File.dirname(__FILE__), '../transport/lxca')

require 'uri'

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
