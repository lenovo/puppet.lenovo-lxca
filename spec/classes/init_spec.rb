require 'spec_helper'
describe 'lxca' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('lxca') }
  end
end
