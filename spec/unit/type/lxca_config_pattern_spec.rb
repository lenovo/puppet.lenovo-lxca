require 'spec_helper'

describe 'lxca_config_pattern', type: :type do
  let(:type_class) { Puppet::Type.type(:lxca_config_pattern) }

  let :params do
    [
      :name,
      :id,
      :endpoints,
      :restart,
      :etype,
      :import_json,
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
    type_class.new(name: 'config pattern ', id: '12', ensure: :present)
  end

  it 'does support :filter_by_id as a value to :ensure' do
    type_class.new(name: 'config pattern by id ', id: '12', ensure: :filter_by_id)
  end

  it 'does support :export_config_pattern as a value to :ensure' do
    type_class.new(name: 'export config pattern', id: '12', ensure: :export_config_pattern)
  end

  it 'does support :deploy_config_pattern as a value to :ensure' do
    type_class.new(name: 'deploy config pattern', id: '12',
                   endpoints: 'B918EDCA1B5F11E2803EBECB82710ADE',
                   restart: 'pending',
                   etype: 'node',
                   ensure: :deploy_config_pattern)
  end

  it 'does support :import_config_pattern as a value to :ensure' do
    type_class.new(name: 'import config pattern',
                   import_json:  '{"template_type" : "SystemInfo","template" : {"contact" : "contact","description" : "Pattern created by ruby test API ","location" : "location","name" : "Learned-System_Info-99","systemName" : {"autogen" : "Disable","hyphenChecked" : "FALSE"},"type" : "SystemInfo","uri" : "\/config\/template\/62","userDefined" : "TRUE"}}',
                   ensure: :import_config_pattern)
  end
end
