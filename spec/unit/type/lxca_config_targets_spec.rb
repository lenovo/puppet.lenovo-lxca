require 'spec_helper'

describe 'lxca_config_target', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_config_target) }

  let :params do
    [
      :name,
      :id,
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

  it 'does support :filter_by_id as a value to :ensure' do
    type_class.new(name: 'config targets by id ', id: '12', ensure: :filter_by_id)
  end
end
