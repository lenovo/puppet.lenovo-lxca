require 'spec_helper'
describe 'lxca' do

  context 'with defaults for all parameters' do
    it { should contain_class('lxca') }
  end
end
