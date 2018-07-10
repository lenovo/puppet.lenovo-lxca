require 'spec_helper'

describe 'lxca_discover_request', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_discover_request) }

  let :params do
    [
      :name,
      :ip_addresses,
      :job_id,
    ]
  end

  let :properties do
    [
    ]
  end

  it 'does have expected properties' do
    properties.each do |property|
      expect(type_class.properties.map(&:name)).to be_include(property)
    end
  end

  it 'does have expected parameters' do
    params.each do |param|
      expect(type_class.parameters).to be_include(param)
    end
  end

  it 'does require a name' do
    expect { type_class.new({}) }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'does support :discover_manageable_devices as a value to :ensure' do
    type_class.new(name: 'Discover manageable device ', ip_addresses: '10.240.4.119', ensure: :discover_manageable_devices)
  end

  it 'does support :monitor_discover_request as a value to :ensure' do
    type_class.new(name: 'monitor discover request ', job_id: '12', ensure: :monitor_discover_request)
  end
end
