require 'spec_helper'

describe 'lxca_config_profile', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_config_profile) }

  let :params do
    [
      :name,
      :id,
      :profile_name,
      :endpoint_uuid,
      :restart,
      :power_down,
      :reset_imm,
      :force,
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
    type_class.new(name: 'config profile ', id: '12', ensure: :present)
  end

  it 'does support :discover_all as a value to :ensure' do
    type_class.new(name: 'all config profile ', ensure: :discover_all)
  end

  it 'does support :filter_by_id as a value to :ensure' do
    type_class.new(name: 'config profile by id ', id: '12', ensure: :filter_by_id)
  end

  it 'does support :unassign_config_profile as a value to :ensure' do
    type_class.new(name: 'unassign config profile ', id: '12',
                   power_down: 'False',
                   reset_imm: 'False',
                   force: 'False',
                   ensure: :unassign_config_profile)
  end

  it 'does support :delete_config_profile as a value to :ensure' do
    type_class.new(name: 'delete config profile by id ', id: '12', ensure: :delete_config_profile)
  end

  it 'does support :rename_config_profile as a value to :ensure' do
    type_class.new(name: 'rename existing config profile', id: '12', profile_name: 'new_profile_name', ensure: :rename_config_profile)
  end

  it 'does support :activate_config_profilen as a value to :ensure' do
    type_class.new(name: 'activate config profile', id: '12',
                   endpoint_uuid: '46920C143355486F97C19A34ABC7D746_bay10',
                   restart: 'defer',
                   ensure: :activate_config_profile)
  end
end
