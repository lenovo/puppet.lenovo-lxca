require 'spec_helper'

describe 'lxca_canister', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_canister) }

  let :params do
    [
      :name,
      :uuid,
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

  it 'does support :discover_all as a value to :ensure' do
    type_class.new(name: 'All Lxca canister ', ensure: :discover_all)
  end

  it 'does support :filter_by_uuid as a value to :ensure' do
    type_class.new(name: 'A Lxca canister ', uuid: '1234567890123456', ensure: :filter_by_uuid)
  end
end
