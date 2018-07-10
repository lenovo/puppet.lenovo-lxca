require 'spec_helper'

describe 'lxca_discovery', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_discovery) }

  let :params do
    [
      :name,
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

  it 'does support :discover_devices_by_slp as a value to :ensure' do
    type_class.new(name: 'discover devices by slp', ensure: :discover_devices_by_slp)
  end
end
