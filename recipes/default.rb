require 'digest/sha2'

# Install dependencies!
node[:ript][:dependencies][:packages].each do |pkg|
  package pkg
end

node[:ript][:dependencies][:gems].each do |g_pkg|
  chef_gem g_pkg
end

directory node[:ript][:base_dir] do
  owner "root"
  group "root"
  mode "0700"
  action :create
end

# Install service!
ruby_block 'install ript service' do
  block do
    FileUtils.cp(File.join(Gem::Specification.find_by_name('ript').full_gem_path, 'dist/init.d'), '/etc/init.d/ript')
  end
  not_if do
    begin
      s_p = File.join(Gem::Specification.find_by_name('ript').full_gem_path, 'dist/init.d')
      d_p = '/etc/init.d/ript'
      if(File.exists?(s_p) && File.exists?(d_p))
        s_sha = Digest::SHA256.new << File.read(s_p)
        d_sha = Digest::SHA256.new << File.read(d_p)
        s_sha == d_sha
      end
    rescue
      false
    end
  end
end

service 'ript' do
  action [:enable, :start]
end

# Done! \o/
