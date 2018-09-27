require 'spec_helper'

describe 'lxca_manage_request', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_manage_request) }

  let :params do
    [
      :name,
      :ip_address,
      :username,
      :password,
      :recovery_password,
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

  it 'does support :manage_discovered_devices as a value to :ensure' do
    type_class.new(name: 'manage device ', ip_address: '10.240.4.119', username: 'USERID', password: 'Test1234', recovery_password: 'New1234', force: 'True', ensure: :manage_discovered_devices)
  end

  it 'does support :fetch_manage_request as a value to :ensure' do
    type_class.new(name: 'Manage job status ', job_id: '12', ensure: :fetch_manage_request)
  end
end
