def load_current_resource
  unless(@runner = new_resource.run_context.resource_collection.lookup('ript[runner]'))
    @runner = Chef::Resource::Ript.new('runner', new_resource.run_context)
    @runner.action :nothing
    new_resource.run_context.resource_collection << @runner
  end
  new_resource.base_dir node[:ript][:base_dir] unless new_resource.base_dir
  new_resource.updated_by_last_action(true)
end

action :write do
  runner = @runner
  file ::File.join(new_resource.base_dir, new_resource.name) do
    content rules.join("\n")
    mode 0644
    notifies :run, runner, :delayed
    only_if {rules = [:ript, :rules, new_resource.name].inject(node.run_state){|m,k| m[k] if m}}
  end
end

action :delete do
  runner = @runner
  file ::File.join(new_resource.base_dir, new_resource.name) do
    action :delete
    notifies :run, runner, :delayed
  end
end
