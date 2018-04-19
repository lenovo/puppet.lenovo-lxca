class Puppet::Util::NetworkDevice::Lxca::Facts
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

    [:Name,
     :UpTime].each do |fact|
      facts[fact] = result[fact.to_s]
    end

    facts.each do |key, value|
      Puppet.notice("Key  = #{key} , Value = #{value}")
    end

    facts
  end
end
