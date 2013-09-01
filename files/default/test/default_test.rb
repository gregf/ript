require 'minitest/spec'

# Cookbook name:: ript
# Spec:: default

describe_recipe 'ript::default' do
  describe 'ensures ript is installed' do
    let(:bin) { file(File.join(Gem::Specification.find_by_name('ript').full_gem_path, 'bin/ript')) }
    it { bin.must_have(:mode, "0755") }
    it { bin.must_have(:owner, "root") }
  end

  describe 'ensures iptables is installed' do
    let(:bin) { file('/sbin/iptables') }
    it { bin.must_have(:mode, "0755") }
    it { bin.must_have(:owner, "root") }
  end

  describe "ensures ript base dir is present" do
    let(:basedir) { directory(node[:ript][:base_dir]) }
    it { basedir.must_have(:mode, "0700") }
    it { basedir.must_have(:owner, "root") }
  end

  describe 'ensures the init script is present' do
    let(:init) { file('/etc/init.d/ript') }
    it { init.must_have(:mode, "0755") }
    it { init.must_have(:owner, "root") }
    it { init.must_include 'NAME=ript' }
  end
end
