require 'spec_helper'

describe 'lxca_node', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_node) }

  let :params do
    [
      :name,
      :uuid,
      :chassis,
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

  it 'does support :present as a value to :ensure' do
    type_class.new(name: 'A Lxca node ', uuid: '1234567890123456', ensure: :present)
  end

  it 'does support :filter_by_uuid as a value to :ensure' do
    type_class.new(name: 'A Lxca node ', uuid: '1234567890123456', ensure: :filter_by_uuid)
  end

  it 'does support :filter_by_chassis as a value to :ensure' do
    type_class.new(name: 'Lxca nodes ', chassis: '1234567890123456', ensure: :filter_by_chassis)
  end

  it 'does support :discover_managed as a value to :ensure' do
    type_class.new(name: 'Managed Lxca nodes ', ensure: :discover_managed)
  end

  it 'does support :discover_unmanaged as a value to :ensure' do
    type_class.new(name: 'Unmanaged Lxca nodes ', ensure: :discover_unmanaged)
  end

  it 'does support :power_on as a value to :ensure' do
    type_class.new(name: 'Power on Lxca nodes ', uuid: '1234567890123456', ensure: :power_on)
  end

  it 'does support :power_off as a value to :ensure' do
    type_class.new(name: 'Power off Lxca nodes ', uuid: '1234567890123456', ensure: :power_off)
  end

  it 'does support :power_restart as a value to :ensure' do
    type_class.new(name: 'Restart Lxca nodes ', uuid: '1234567890123456', ensure: :power_restart)
  end

  it 'does support :blink_led as a value to :ensure' do
    type_class.new(name: 'Blink led of Lxca nodes ', uuid: '1234567890123456', ensure: :blink_led)
  end

  it 'does support :turn_on_led as a value to :ensure' do
    type_class.new(name: 'Trun on led of Lxca nodes ', uuid: '1234567890123456', ensure: :turn_on_led)
  end

  it 'does support :turn_off_led as a value to :ensure' do
    type_class.new(name: 'Trun off led of Lxca nodes ', uuid: '1234567890123456', ensure: :turn_off_led)
  end
end
