require 'spec_helper'

describe 'lxca_unmanage_request', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_unmanage_request) }

  let :params do
    [
      :name,
      :endpoints,
      :force,
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

  it 'does support :unmanage_discovered_devices as a value to :ensure' do
    type_class.new(name: 'manage device ', endpoints: [{ 'ipAddresses' => ['10.243.8.28'], 'type' => 'Chassis', 'uuid' => '792812BA57B24337821B72AC27CF2055' }],
                   force: 'True', ensure: :unmanage_discovered_devices)
  end

  it 'does support :fetch_unmanage_request as a value to :ensure' do
    type_class.new(name: 'Unmanage job status ', job_id: '12', ensure: :fetch_unmanage_request)
  end
end
